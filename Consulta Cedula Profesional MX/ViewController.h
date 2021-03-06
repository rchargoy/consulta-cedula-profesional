//
//  ViewController.h
//  Consulta Cedula Profesional MX
//
//  Created by Rogert Chargoy on 1/21/15.
//  Copyright (c) 2015 Rogert Chargoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *desins;
@property (nonatomic, strong) IBOutlet UILabel *titulo;
@property (nonatomic, strong) IBOutlet UILabel *idCedula;

@property (strong, nonatomic) IBOutlet UITextField *nombre;
@property (strong, nonatomic) IBOutlet UITextField *ApPaterno;
@property (strong, nonatomic) IBOutlet UITextField *ApMaterno;

- (IBAction)fetchCedula;

@end