//
//  Contacto.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 13/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Contacto.h"
#import <Parse/Parse.h>

@interface Contacto ()

@end

@implementation Contacto

@synthesize contact_asunto_txt,contact_mensaje_txt,contact_nombre_txt,datos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contact_asunto_txt.delegate = self;
    contact_mensaje_txt.delegate = self;
    contact_nombre_txt.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)regresar:(id)sender {
    [self dismissViewControllerAnimated:YES  completion:nil];
}

-(IBAction)enviar_contacto{
    
    NSString *nombre;
    NSString *mensaje;
    NSString *asunto;
    nombre = contact_nombre_txt.text;
    mensaje = contact_mensaje_txt.text;
    asunto = contact_asunto_txt.text;
    
    if (nombre.length == 0 || mensaje.length == 0 || asunto.length == 0 )
    {
        UIAlertView *alert_error  = [[UIAlertView alloc ] initWithTitle:@"Error" message:@"Campos Vacios" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert_error show];
        
    }
    else{
        PFUser *user = [PFUser currentUser];
        PFObject *contacto = [PFObject objectWithClassName:@"Contacto"];
        contacto[@"Nombre"] = nombre;
        contacto[@"Mensaje"] = mensaje;
        contacto[@"Asunto"] = asunto;
        [contacto setObject:user forKey:@"quien_contacta"];
        [contacto saveInBackground];
        
        UIAlertView *alert_error  = [[UIAlertView alloc ] initWithTitle:@"Gracias" message:@"Tu informacion ha sido enviada" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert_error show];
        [self limpia_campos];
        
        
    }
}
-(void)limpia_campos{
    contact_mensaje_txt.text = @"";
    contact_nombre_txt.text = @"";
    contact_asunto_txt.text = @"";
    [contact_nombre_txt resignFirstResponder];
    [contact_mensaje_txt resignFirstResponder];
    [contact_asunto_txt resignFirstResponder];
    [self regresarframes];

}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    /*if(theTextField==contact_nombre_txt){
        [contact_asunto_txt becomeFirstResponder];
    }
    else if(theTextField==contact_asunto_txt){
        [contact_mensaje_txt becomeFirstResponder];
    }*/
    return YES;
}
- (IBAction)cerrart{
    [contact_mensaje_txt resignFirstResponder];
    [contact_asunto_txt resignFirstResponder];
  [self   regresarframes];

}
- (IBAction)cerrarname:(id)sender {

    [contact_nombre_txt resignFirstResponder];
    [self   regresarframes];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if(textField == contact_asunto_txt){
        [self trans_asunto];
    }else if (textField == contact_mensaje_txt){
        [self trans_mensaje];
    }
}
-(void)regresarframes{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = 0;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}


-(void)trans_asunto{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.7];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = -60;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}
-(void)trans_mensaje{
    [UIView beginAnimations:@"advancedAnimations" context:nil];
    [UIView setAnimationDuration:0.5];
    datos.alpha = 1.0;
    CGRect frame_datos = datos.frame;
    frame_datos.origin.x = 0;
    frame_datos.origin.y = -140;
    datos.frame = frame_datos;
    [UIView commitAnimations];
}
@end
