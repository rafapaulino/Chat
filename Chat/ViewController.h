//
//  ViewController.h
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalaChat.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtApelido;
- (IBAction)entrar:(id)sender;

@end
