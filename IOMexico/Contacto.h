//
//  Contacto.h
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 13/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Contacto : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *contact_nombre_txt;
@property (strong, nonatomic) IBOutlet UITextField *contact_asunto_txt;
@property (strong, nonatomic) IBOutlet UITextField *contact_mensaje_txt;
- (IBAction)cerrart;
@end
