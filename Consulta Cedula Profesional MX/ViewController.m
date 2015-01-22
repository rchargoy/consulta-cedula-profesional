//
//  ViewController.m
//  Consulta Cedula Profesional MX
//
//  Created by Rogert Chargoy on 1/21/15.
//  Copyright (c) 2015 Rogert Chargoy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)fetchCedula;
{
    NSURL *url = [NSURL URLWithString:@"http://www.cedulaprofesional.sep.gob.mx/cedula/buscaCedulaJson.action?json=%7B%22maxResult%22%3A%221000%22%2C%22idCedula%22%3A%22%22%2C%22terminos%22%3A%22false%22%2C%22nombre%22%3A%22ROGACIANO%22%2C%22paterno%22%3A%22CHARGOY%22%2C%22materno%22%3A%22DEL%20ANGEL%22%2C%22h_genero%22%3A%22%22%2C%22genero%22%3A%22%22%2C%22annioInit%22%3A%22%22%2C%22annioEnd%22%3A%22%22%2C%22insedo%22%3A%22%22%2C%22inscons%22%3A%22%22%2C%22institucion%22%3A%22TODAS%22%2C%22condiciones%22%3A%22false%22%7D"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             
             NSError *error2;
             NSString *string = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:&error2];
             NSData *utf8Data = [string dataUsingEncoding:NSUTF8StringEncoding];
             id jsonObject = [NSJSONSerialization JSONObjectWithData:utf8Data options:kNilOptions error:&error2];
             
             if (error2) {
                 NSLog(@"Error: %@", error2);
             } else {
                 NSArray *cedulas = [jsonObject objectForKey:@"items"];
                 //NSLog(@"cedulas[]: %@", [cedulas objectAtIndex:(0)] ) ;
                 self.titulo.text = [[cedulas objectAtIndex:(0)] objectForKey:@"titulo"];
                 self.idCedula.text = [[cedulas objectAtIndex:(0)] objectForKey:@"idCedula"];
                 self.desins.text = [[cedulas objectAtIndex:(0)] objectForKey:@"desins"];
                 //NSLog(@"desins: %@", [[cedulas objectAtIndex:(0)] objectForKey:@"desins"] ) ;
                 
                 
             }
             
         }
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchCedula];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end