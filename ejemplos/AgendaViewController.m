//
//  AgendaViewController.m
//  ejemplos
//
//  Created by Xavi on 21/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import "AgendaViewController.h"
#import "AppDelegate.h"
#import <sqlite3.h>
#import "DetalleContactoViewController.h"


@interface AgendaViewController (){
    NSMutableArray *agenda;
    NSMutableArray *agendaSel;
    NSMutableArray *agendaMostrar;
}

@end

@implementation AgendaViewController
@synthesize agendaTableView;
@synthesize searchBarFiltro;
//@synthesize viewNuevoContacto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"View appears");
    [agenda removeAllObjects];
    [self cargarAgenda];
    NSString *texto=[NSString stringWithString:self.searchBarFiltro.text];
    NSLog(@"valor searchbar-%@-",texto);
    if ([texto isEqualToString:@""]) {
        agendaMostrar=agenda;        
    }else{
        agendaMostrar=agendaSel;
    }
    [self.agendaTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    agenda = [[NSMutableArray alloc]init];
    agendaSel = [[NSMutableArray alloc]init];
    //[self cargarAgenda];
    //[self.agendaTableView reloadData];

	// Do any additional setup after loading the view.
}

-(void)cargarAgenda{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    sqlite3 *database;
    sqlite3_stmt *sentencia;
    //NSLog(@"databasePath = %s", [appDelegate.dataBasePath UTF8String]);
    if (sqlite3_open([appDelegate.dataBasePath UTF8String],&database) == SQLITE_OK){
        NSString *sql=[NSString stringWithFormat:@"Select * from persona order by nombre"];
        if ( sqlite3_prepare_v2(database, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
            while(sqlite3_step(sentencia)==SQLITE_ROW){
                NSMutableDictionary *dic= [[NSMutableDictionary alloc]init];
                NSString *id = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,0)];
                [dic setValue:id forKey:@"id"];
                NSString *nombre = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,1)];
                [dic setValue:nombre forKey:@"nombre"];
                NSString *tlf = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,2)];
                [dic setValue:tlf forKey:@"telefono"];
                NSString *mail = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,8)];
                [dic setValue:mail forKey:@"mail"];
                NSString *calle = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,3)];
                [dic setValue:calle forKey:@"calle"];
                NSString *cp = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,4)];
                [dic setValue:cp forKey:@"cp"];
                NSString *ciudad = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,5)];
                [dic setValue:ciudad forKey:@"ciudad"];
                NSString *pais = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,6)];
                [dic setValue:pais forKey:@"pais"];
                NSString *urlFoto = [NSString stringWithUTF8String:(char*) sqlite3_column_text(sentencia,7)];
                [dic setValue:urlFoto forKey:@"urlFoto"];
                [agenda addObject:dic];
            }
        }else{
        }
        sqlite3_finalize(sentencia);
    }else{
       
    }
    sqlite3_close(database);
}

- (void)viewDidUnload
{
    [self setAgendaTableView:nil];
    [self setSearchBarFiltro:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBarFiltro resignFirstResponder];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView{
    [self.searchBarFiltro resignFirstResponder];
}

- (void) searchBar:(UISearchBar*) searchBar textDidChange:(NSString *)text{
    NSString *texto= [NSString stringWithString:text] ;

    [agendaSel removeAllObjects];
    if (texto==nil || [texto isEqualToString: @""] ) {
        for (int i=0; i< [agenda count];i++) {
            [agendaSel addObject:[agenda objectAtIndex:i]];
        }
    }else{
         
        for (int i=0; i< [agenda count];i++) {
            NSDictionary *dicF= [agenda objectAtIndex:i];
            NSRange nameRange =[[dicF objectForKey:@"nombre"] rangeOfString:texto options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound){
                [agendaSel addObject:[agenda objectAtIndex:i]];
            }
        }
    }
    agendaMostrar=agendaSel;
    [self.agendaTableView reloadData];
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [agendaMostrar count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
     NSDictionary *dic= [agendaMostrar objectAtIndex:indexPath.row];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [dic objectForKey:@"nombre"];
    NSString *detalle=[NSString stringWithFormat:@"%@ - %@",[dic objectForKey:@"telefono"],[dic objectForKey:@"mail"]];
    cell.detailTextLabel.text = detalle;
    
    //CGRect frame; frame.size.width = 75; frame.size.height = 75; frame.origin.x = 0; frame.origin.y = 1;
    //NSURL *url= [NSURL URLWithString:[dic objectForKey:@"urlFoto"]];
    //NSData *data=[NSData dataWithContentsOfURL:url];
    //UIImage *img= [UIImage imageWithData:data];

    //cell.imageView.image=[UIImage imageWithData:data];
    //[UIImage imageNamed:@"imagen2.png"];
    
    /*AsyncImageView *asyncImage= [[AsyncImageView alloc] initWithFrame:frame] ;
    asyncImage.tag = 999;
    NSURL* url = [NSURL URLWithString:[dic objectForKey:@"urlFoto"]];
    [asyncImage loadImageFromURL:url];
    [cell.contentView addSubview:asyncImage];
    cell.imageView.image=asyncImage.image;
*/
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nill];
     */
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *contacto = [agendaMostrar objectAtIndex:indexPath.row];
    NSLog(@"%@",contacto);

    DetalleContactoViewController *detalle = [self.storyboard instantiateViewControllerWithIdentifier:@"DetalleContactoViewController"];

    detalle.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self.tabBarController presentModalViewController:detalle animated:YES];
    
    [detalle.labelTelefono setText:[contacto objectForKey:@"telefono"]];
    [detalle.labelMail setText:[contacto objectForKey:@"mail"]];
    NSString *direccion= [NSString stringWithFormat:@"%@,%@  %@,%@",[contacto objectForKey:@"calle"],[contacto objectForKey:@"cp"],[contacto objectForKey:@"ciudad"],[contacto objectForKey:@"pais"]];
    [detalle.labelDireccion setText:direccion];
    detalle.stringUrlFoto = [contacto objectForKey:@"urlFoto"];
    detalle.navigatioBarNombre.topItem.title = [contacto objectForKey:@"nombre"];
    //
    //[self.navigationController pushViewController:detalle animated:YES];
  /*  DetalleViewController *detalle = [self.storyboard instantiateViewControllerWithIdentifier:@"DetalleViewController"];
    [self.navigationController pushViewController:detalle animated:YES];
    [detalle.nombreDetalle setText:[jugador objectForKey:@"nombre"]];
    [detalle.imagenDetalle setImage:[UIImage imageNamed:[jugador objectForKey:@"imagen"]]];
    */
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

    




- (IBAction)gestosEnAgenda:(id)sender {
    CGPoint movimiento = [sender translationInView:self.view];
    NSLog(@"Gestos");
    if (movimiento.x<0) { //vamos a la derecha
        [self.tabBarController setSelectedIndex:1];
    }else{
        [self.tabBarController setSelectedIndex:0];
    }
}

@end
