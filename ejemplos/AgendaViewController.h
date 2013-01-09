//
//  AgendaViewController.h
//  ejemplos
//
//  Created by Xavi on 21/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgendaViewController : UIViewController <UISearchBarDelegate>{
    //IBOutlet UIView *viewNuevoContacto;
}
@property (weak, nonatomic) IBOutlet UITableView *agendaTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarFiltro;
//@property(weak, nonatomic) UIView *viewNuevoContacto;
- (IBAction)gestosEnAgenda:(id)sender;

@end
