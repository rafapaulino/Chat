//
//  ViewController.m
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txtApelido;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTxtApelido:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark Entrar na sala

- (IBAction)entrar:(id)sender
{
    //caso tenha algum texto nos permitiremos a conexao
    if ([txtApelido.text length] > 0)
    {
        SalaChat *sala = [self.storyboard instantiateViewControllerWithIdentifier:@"idSalaChat"];
        
        //passando o apelido para a proxima tela
        sala.strApelido = txtApelido.text;
        
        //apresentando a view
        [self presentModalViewController:sala animated:YES];
        
    }
    else
    {
        UIAlertView * alerta = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Preencha o campo apelido" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
        [alerta show];
    }
}

@end
