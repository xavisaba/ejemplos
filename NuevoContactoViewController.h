//
//  NuevoContactoViewController.h
//  ejemplos
//
//  Created by Xavi on 21/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NuevoContactoViewController : UIViewController <UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate>{
    UITextField* textFieldNombre ;
    UITextField* textFieldTelefono ;
    UITextField* textFieldMail ;
    UITextField* textFieldUrlFoto ;
    UITextField* textFieldCalle ;
    UITextField* textFieldPais ;
    UITextField* textFieldCiudad ;
    UITextField* textFieldCodigoPostal ;
}

@property (retain,nonatomic) NSString* stringNombre ;
@property (retain,nonatomic) NSString* stringTelefono ;
@property (retain,nonatomic) NSString* stringMail ;
@property (retain,nonatomic) NSString* stringUrlFoto ;
@property (retain,nonatomic) NSString* stringCalle ;
@property (retain,nonatomic) NSString* stringPais ;
@property (retain,nonatomic) NSString* stringCiudad ;
@property (retain,nonatomic) NSString* stringCodigoPostal ;

@property (strong, nonatomic) IBOutlet UIView *tableViewFormNuevoContacto;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UITextField *activeField;
@property (retain, nonatomic) IBOutlet NSIndexPath *activeIndex;
@property (weak, nonatomic) IBOutlet UITableView *tablaNuevoContacto;

- (IBAction)insertarContacto:(id)sender;
- (IBAction)gestosEnNuevoContacto:(id)sender;





@end
