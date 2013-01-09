//
//  DetalleContactoViewController.m
//  ejemplos
//
//  Created by Xavi on 23/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import "DetalleContactoViewController.h"
#import "AgendaViewController.h"
#import "MapaViewController.h"

@interface DetalleContactoViewController ()

@end

@implementation DetalleContactoViewController
@synthesize labelTelefono;
@synthesize labelMail;
@synthesize labelDireccion;
@synthesize navigatioBarNombre;

@synthesize imagen;
@synthesize indicadorActividad;
@synthesize stringUrlFoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mostrarImagen;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLabelTelefono:nil];
    [self setLabelMail:nil];
    [self setLabelDireccion:nil];
    [self setNavigatioBarNombre:nil];
    [self setImagen:nil];
    [self setIndicadorActividad:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)volverAAgenda:(id)sender {
    AgendaViewController *detalle = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaViewController"];
    //[self.navigationController pushViewController:detalle animated:YES];
    [self.navigationController pushViewController:detalle animated:YES];
    //[self.tabBarController presentModalViewController:detalle animated:YES];
}



-(void)mostrarImagen{
    NSOperationQueue *queue=[NSOperationQueue new];
    NSInvocationOperation *operacion= [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(cargarImagen) object:nil];
    [queue addOperation:operacion];
    [indicadorActividad setHidden:NO];
    [indicadorActividad startAnimating];
}

- (IBAction)pulsarBotonCamara:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Elige" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Camara",@"Libreria", nil];
    [sheet showInView:self.view];

}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self iniciarCamara];
    }else if (buttonIndex== 1){
        [self iniciarLibreria];
    }else if (buttonIndex ==2){
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void) iniciarCamara{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [pickerController setDelegate:self];
    
    [self presentModalViewController:pickerController animated:YES];
    
}

-(void) iniciarLibreria{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [pickerController setDelegate:self];
    
    [self presentModalViewController:pickerController animated:YES];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagen setImage:image];
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)pulsarBotonDetalleContacto:(id)sender {
    UIBarButtonItem *boton = (UIBarButtonItem *) sender;
    NSLog(@"%d",boton.tag);
    if (boton.tag==1) {
        NSString *phoneNumber = self.labelTelefono.text; // Cambiar por el número de teléfono al que llamar
        NSURL *cleanPhoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"%@", phoneNumber]];
        [[UIApplication sharedApplication] openURL:cleanPhoneNumber];
    }else if (boton.tag==4) {
        MapaViewController *mapa= [self.storyboard instantiateViewControllerWithIdentifier:@"MapaViewController"];
        [self presentModalViewController:mapa animated:YES];
        mapa.navigationBarDireccion.title = self.labelDireccion.text;
        mapa.nombre=self.navigatioBarNombre.topItem.title;
        mapa.tlf=self.labelTelefono.text;
    }
    else if (boton.tag==2) {
        //Creamos el controller encargado de los mails
        MFMailComposeViewController *m = [[MFMailComposeViewController alloc] init];
        //Asignamos los destinos a los que envíar el email
        [m setToRecipients:[NSArray arrayWithObject:self.labelMail.text]];
        m.mailComposeDelegate = self;
        m.navigationBar.topItem.title=@"Mail";
        

        //Mostramos la vista de edición de email
        [self presentModalViewController:m animated:YES];
    }else if (boton.tag == 3){
        //Creamos el controller encargado de los mails
        MFMessageComposeViewController *s = [[MFMessageComposeViewController alloc] init];
        //Asignamos los destinos a los que envíar el email
        [s setRecipients:[NSArray arrayWithObject:self.labelTelefono.text]];
        s.messageComposeDelegate = self;
        s.navigationBar.topItem.title=@"Sms";
        //Mostramos la vista de edición de email
        [self presentModalViewController:s animated:YES];
    }
    

    
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
            break;
            
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    
    //Dismiss the mailViewController.
    [self dismissModalViewControllerAnimated:YES];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{

    switch (result) {
        case MFMailComposeResultCancelled:
            
            break;
            
        case MFMailComposeResultSaved:
            break;
            
        case MFMailComposeResultSent:
            break;
            
        case MFMailComposeResultFailed: {
            
            break;
        }
        default:
            break;
    }
    
    //Dismiss the mailViewController.
    [self dismissModalViewControllerAnimated:YES];
}

-(void)cargarImagen{
    if ([self.stringUrlFoto hasPrefix:@"http:"]!= NSNotFound) {
        NSString *strUrl=[NSString stringWithFormat:self.stringUrlFoto];
        NSURL *url= [NSURL URLWithString:strUrl];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img= [UIImage imageWithData:data];
        [self.imagen performSelectorOnMainThread:@selector(setImage:) withObject:img waitUntilDone:YES];
    }
   
    [indicadorActividad stopAnimating];
    [indicadorActividad setHidden:YES];

}

@end
