//
//  MapaViewController.h
//  ejemplos
//
//  Created by Xavi on 23/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapaViewController : UIViewController <MKMapViewDelegate>

@property (retain, nonatomic) IBOutlet UINavigationItem *navigationBarDireccion;
@property (retain, nonatomic) IBOutlet NSString *nombre;
@property (retain, nonatomic) IBOutlet NSString *tlf;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)pulsarBotonTipoMapa:(id)sender;
@end
