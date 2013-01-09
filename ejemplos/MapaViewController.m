//
//  MapaViewController.m
//  ejemplos
//
//  Created by Xavi on 23/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import "MapaViewController.h"

@interface MapaViewController ()

@end

@implementation MapaViewController
@synthesize navigationBarDireccion;
@synthesize mapView;
@synthesize nombre,tlf;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    // Do any additional setup after loading the view.
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    
    NSString *dir=[NSString stringWithString:navigationBarDireccion.title];
    CLLocationCoordinate2D cordPunto = [self getLocationFromAddressString:self.navigationBarDireccion.title];
    
    region.center=cordPunto;
    region.span=span;
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
    
    
    //(CLLocationCoordinate2DMake(region.center.latitude,region.center.longitude));
    MKPointAnnotation *anotacion =[[MKPointAnnotation alloc] init];
    [anotacion setCoordinate:cordPunto];
    [anotacion setTitle:self.nombre];
    [anotacion setSubtitle:self.tlf];
    [self.mapView addAnnotation:anotacion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView.delegate=self;
	
}

- (void)viewDidUnload
{
    [self setNavigationBarDireccion:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    
        
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressStr {
    NSString *urlStr = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",
                        [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *locationStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr]];
    NSArray *items = [locationStr componentsSeparatedByString:@","];
    
    double lat = 0.0;
    double lon = 0.0;
    
    if([items count] >= 4 && [[items objectAtIndex:0] isEqualToString:@"200"]) {
        lat = [[items objectAtIndex:2] doubleValue];
        lon = [[items objectAtIndex:3] doubleValue];
    }
    else {
        NSLog(@"Address, %@ not found: Error %@",addressStr, [items objectAtIndex:0]);
    }
    
    CLLocationCoordinate2D cordPunto = (CLLocationCoordinate2DMake(lat,lon));
        
    return cordPunto;
}

- (IBAction)pulsarBotonTipoMapa:(id)sender {
    UIBarButtonItem *boton = (UIBarButtonItem *) sender;
    NSLog(@"%d",boton.tag);
    switch (boton.tag) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1:
            [mapView setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [mapView setMapType:MKMapTypeStandard];
            break;
        case 3:
            [mapView setMapType:MKMapTypeHybrid];
            break;
        default:
            break;
    }

}
@end
