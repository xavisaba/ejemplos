//
//  DetalleContactoViewController.h
//  ejemplos
//
//  Created by Xavi on 23/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetalleContactoViewController : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelTelefono;
@property (weak, nonatomic) IBOutlet UILabel *labelMail;
@property (weak, nonatomic) IBOutlet UILabel *labelDireccion;

@property (weak, nonatomic) IBOutlet NSString *stringUrlFoto;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigatioBarNombre;



@property (weak, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicadorActividad;
- (IBAction)volverAAgenda:(id)sender;
-(void)mostrarImagen;
- (IBAction)pulsarBotonCamara:(id)sender;
-(void) iniciarCamara;
-(void) iniciarLibreria;

- (IBAction)pulsarBotonDetalleContacto:(id)sender;
@end
