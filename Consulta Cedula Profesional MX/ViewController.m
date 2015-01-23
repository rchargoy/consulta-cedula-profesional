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
#define AS(A,B)    [(A) stringByAppendingString:(B)]
    
    
    NSString *nombreUrl = @"";
    NSString *apPaternoUrl =@"";
    NSString *apMaternoUrl =@"";
    
    nombreUrl =  [self.nombre.text stringByAddingPercentEscapesUsingEncoding:
                     NSUTF8StringEncoding];
    apPaternoUrl =  [self.ApPaterno.text stringByAddingPercentEscapesUsingEncoding:
                     NSUTF8StringEncoding];
    apMaternoUrl =  [self.ApMaterno.text stringByAddingPercentEscapesUsingEncoding:
                     NSUTF8StringEncoding];
    
    
    if([nombreUrl isEqualToString:@"[nombre]"]){
        nombreUrl = @"ROGACIANO";
    }

    if([apMaternoUrl isEqualToString:@"[ApPaterno]"]){
        apMaternoUrl = @"CHARGOY";
    }
    
    if([apMaternoUrl isEqualToString:@"[ApMaterno]"]){
        apMaternoUrl = @"DEL%20ANGEL";
    }
    
    NSString *url1 = @"http://www.cedulaprofesional.sep.gob.mx/cedula/buscaCedulaJson.action?json=%7B%22maxResult%22%3A%221000%22%2C%22idCedula%22%3A%22%22%2C%22terminos%22%3A%22false%22%2C%22nombre%22%3A%22";
    
    NSString *url2 =@"%22%2C%22paterno%22%3A%22";
    
    NSString *url3 =@"%22%2C%22materno%22%3A%22";
    
    NSString *url4 = @"%22%2C%22h_genero%22%3A%22%22%2C%22genero%22%3A%22%22%2C%22annioInit%22%3A%22%22%2C%22annioEnd%22%3A%22%22%2C%22insedo%22%3A%22%22%2C%22inscons%22%3A%22%22%2C%22institucion%22%3A%22TODAS%22%2C%22condiciones%22%3A%22false%22%7D";
    
        NSLog(@"URL FINAL:%@ - %@", nombreUrl, apMaternoUrl);

    NSString *urlString = AS(url1, nombreUrl);
        urlString = AS(urlString, url2);
        urlString = AS(urlString, apPaternoUrl);
        urlString = AS(urlString, url3);
        urlString = AS(urlString, apMaternoUrl);
        urlString = AS(urlString, url4);
    NSLog(@"URL FINAL:%@", urlString);

    
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"URL FINAL:%@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSLog(@"URL REQUEST: %@", request);
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
             NSLog(@"URL RESPONSE: %@", response);
         if (data.length > 0 && connectionError == nil)
         {
             
             NSError *error2;
             NSString *string = [NSString stringWithContentsOfURL:url encoding:NSISOLatin1StringEncoding error:&error2];
             NSData *utf8Data = [string dataUsingEncoding:NSUTF8StringEncoding];
             id jsonObject = [NSJSONSerialization JSONObjectWithData:utf8Data options:kNilOptions error:&error2];
             
             if (error2) {
                 NSLog(@"Error: %@", error2);
             } else {
                 NSLog(@"OBTENCION DATOS CEDULAS #########: %@", jsonObject) ;
                 NSArray *cedulas = [jsonObject objectForKey:@"items"];
                 NSLog(@"OBTENCION DATOS CEDULAS ========= %@", cedulas) ;
                 NSLog(@"OBTENCION DATOS longitud ========= %lu", (unsigned long)[ cedulas count ]) ;
                
                 //NSLog(@"cedulas[]: %@", [cedulas objectAtIndex:(0)] ) ;
                 
                     if (cedulas && [ cedulas count ] > 0) {
                 NSLog(@"ACTUALIZANDO.......") ;
                     self.titulo.text = [[cedulas objectAtIndex:(0)] objectForKey:@"titulo"];
                     self.idCedula.text = [[cedulas objectAtIndex:(0)] objectForKey:@"idCedula"];
                     self.desins.text = [[cedulas objectAtIndex:(0)] objectForKey:@"desins"];
                     //NSLog(@"desins: %@", [[cedulas objectAtIndex:(0)] objectForKey:@"desins"] ) ;
                     }else{
                         self.titulo.text = @"No encontrado";
                         self.idCedula.text = @"No encontrado";
                         self.desins.text = @"No encontrado";
                     }
                 
             }
             
         }
     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Captura: %@",self.nombre.text);
    [self.nombre resignFirstResponder];
    return YES;
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