//
//  NuevoContactoViewController.m
//  ejemplos
//
//  Created by Xavi on 21/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import "NuevoContactoViewController.h"
#import "AppDelegate.h"
#import <sqlite3.h>



@interface NuevoContactoViewController ()

@end

@implementation NuevoContactoViewController
@synthesize tableViewFormNuevoContacto,stringCalle,stringCiudad,stringCodigoPostal,stringMail,stringNombre,stringPais,stringTelefono,stringUrlFoto;
@synthesize scrollView;
@synthesize activeField;
@synthesize activeIndex;
@synthesize tablaNuevoContacto;

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
    self.stringCalle=@"";
    self.stringCiudad=@"";
    self.stringCodigoPostal=@"";
    self.stringMail=@"";
    self.stringNombre=@"";
    self.stringPais=@"";
    self.stringTelefono=@"";
    self.stringUrlFoto=@"";
    // Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidUnload
{
    [self setTableViewFormNuevoContacto:nil];
    [self setTablaNuevoContacto:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 4;
            break;
        default:
            break;
    }
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Datos personales";
            break;
        case 1:
            return @"Imagen a mostrar";
            break;
        case 2:
            return @"Direccion de contacto";
            break;
        default:
            break;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITextField *inputField;
    inputField=nil;
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        inputField = [[UITextField alloc] initWithFrame:CGRectMake(132,12,185,30)];
        inputField.adjustsFontSizeToFitWidth = YES;
        //inputField.tag = 2;
        [cell addSubview:inputField];
                
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
        label.backgroundColor = [UIColor clearColor];
        //label.tag = 1;
        [cell.contentView addSubview:label];
    }
    inputField.keyboardType = UIKeyboardTypeDefault;
    inputField.delegate=self;
    switch ([indexPath section]) {            
        case 0:
            switch([indexPath row])
            {
                case 0:
                    cell.textLabel.text = @"Nombre";
                    inputField.placeholder = @"...";
                    inputField.tag=1;
                    textFieldNombre=inputField;
                    break;
                case 1:
                    inputField.keyboardType = UIKeyboardTypeNumberPad;
                    cell.textLabel.text = @"Telefono";
                    inputField.placeholder = @"...";
                    inputField.tag=2;
                    textFieldTelefono=inputField;
                    break;
                case 2:
                    cell.textLabel.text = @"Mail";
                    inputField.placeholder = @"...";
                    inputField.tag=3;
                    textFieldMail=inputField;
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch([indexPath row])
            {
                case 0:
                    cell.textLabel.text = @"URL Foto";
                    inputField.placeholder = @"...";
                    inputField.tag=4;
                    textFieldUrlFoto=inputField;
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch([indexPath row])
            {
                case 0:
                    cell.textLabel.text = @"Calle";
                    inputField.placeholder = @"...";
                    inputField.tag=5;
                    textFieldCalle=inputField;
                    break;
                case 1:
                    cell.textLabel.text = @"País";
                    inputField.placeholder = @"...";
                    inputField.tag=6;
                    textFieldPais=inputField;
                    break;
                case 2:
                    cell.textLabel.text = @"Ciudad";
                    inputField.placeholder = @"...";
                    inputField.tag=7;
                    textFieldCiudad=inputField;
                    break;
                case 3:
                    inputField.keyboardType = UIKeyboardTypeNumberPad;
                    cell.textLabel.text = @"Código postal";
                    inputField.placeholder = @"...";
                    inputField.tag=8;
                    textFieldCodigoPostal=inputField;
                    break;
            }
        default:
            break;
    }
    return cell;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [textFieldNombre resignFirstResponder];
    [textFieldCalle resignFirstResponder];
    [textFieldCiudad resignFirstResponder];
    [textFieldCodigoPostal resignFirstResponder];
    [textFieldMail resignFirstResponder];
    [textFieldPais resignFirstResponder];
    [textFieldTelefono resignFirstResponder];
    [textFieldUrlFoto resignFirstResponder];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView{
    [textFieldNombre resignFirstResponder];
    [textFieldCalle resignFirstResponder];
    [textFieldCiudad resignFirstResponder];
    [textFieldCodigoPostal resignFirstResponder];
    [textFieldMail resignFirstResponder];
    [textFieldPais resignFirstResponder];
    [textFieldTelefono resignFirstResponder];
    [textFieldUrlFoto resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            NSLog(@"---NombreTF:%@", textField.text);
            self.stringNombre = [NSString stringWithString:textField.text];
            NSLog(@"---nombreST:%@", self.stringNombre);
            break;
        case 2:
            self.stringTelefono = [NSString stringWithString:textField.text];
            break;
        case 3:
            self.stringMail = [NSString stringWithString:textField.text];
            break;
        case 4:
            self.stringUrlFoto = [NSString stringWithString:textField.text];
            break;
        case 5:
            NSLog(@"---CalleTF:%@", textField.text);
            self.stringCalle = [NSString stringWithString:textField.text];
            NSLog(@"---CalleST:%@", self.stringCalle);
            break;
        case 6:
            self.stringPais = [NSString stringWithString:textField.text];
            break;
        case 7:
            self.stringCiudad = [NSString stringWithString:textField.text];
            break;
        case 8:
            self.stringCodigoPostal = [NSString stringWithString:textField.text];
            break;
        default:
            break;
    }
    activeField = nil;
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.activeIndex = nil;
     /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nill];
     */
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.activeIndex = indexPath;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (IBAction)insertarContacto:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *database;
    sqlite3_stmt *sentencia;
    UIAlertView *alerta=[[UIAlertView alloc]init];
    [alerta setTitle:@"Agenda"];
    [alerta addButtonWithTitle:@"OK"];
    [alerta setMessage:@"Contacto insetado correctamente"];
    NSLog(@"----------Calle:%@----------",self.stringCalle);
    NSLog(@"databasePath = %s", [appDelegate.dataBasePath UTF8String]);
    if (sqlite3_open([appDelegate.dataBasePath UTF8String],&database) == SQLITE_OK){
        NSLog(@"BD abierta");
        NSString *sql=[NSString stringWithFormat:@"Insert into persona (\"nombre\" , \"telefono\" , \"calle\" , \"cp\" , \"ciudad\" , \"pais\" , \"urlFoto\" , \"mail\") VALUES (\"%@\" , \"%@\" , \"%@\" , \"%@\" , \"%@\" , \"%@\" , \"%@\" , \"%@\")", self.stringNombre,self.stringTelefono,self.stringCalle,self.stringCodigoPostal,self.stringCiudad,self.stringPais,self.stringUrlFoto,self.stringMail ];
        NSLog(@"Nuestra sentencia SQL:%@",sql);
        NSLog(@"%i,%i", sqlite3_prepare_v2(database, [sql UTF8String], -1, &sentencia, NULL),SQLITE_OK);
        if ( sqlite3_prepare_v2(database, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
            NSLog(@"%s",sqlite3_errmsg(database));
            while(sqlite3_step(sentencia)==SQLITE_OK){
                NSLog(@"Sentencia ejecutada correctamente");
            }
        }else{
            NSLog(@"%s",sqlite3_errmsg(database));
            NSLog(@"Error en nuestra sentencia");
            [alerta setMessage:@"Error al insertar"];
        }
        sqlite3_finalize(sentencia);
    }else{
        NSLog(@"No se ha podido abrir la BD");
    }
    sqlite3_close(database);
    [alerta show];
    
}

- (IBAction)gestosEnNuevoContacto:(id)sender {
    CGPoint movimiento = [sender translationInView:self.view];
    NSLog(@"gestaco");
    if (movimiento.x>0) { //vamos a la derecha
    //    [self.tabBarController setSelectedIndex:0];
    }
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
 
    aRect.size.height -= kbSize.height;
    CGPoint textFieldCenter = activeField.center;
    CGPoint pointInTableView = [tablaNuevoContacto convertPoint:textFieldCenter fromView:activeField.superview];
    if (!CGRectContainsPoint(aRect, pointInTableView) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y+(kbSize.height-12));
        [self.tablaNuevoContacto setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    
}



@end
