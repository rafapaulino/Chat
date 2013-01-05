//
//  SalaChat.m
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "SalaChat.h"

@interface SalaChat ()
{
    ControleRede *rede;
    NSMutableArray *arrayMensagens;
}

@end

@implementation SalaChat
@synthesize lblApelido;
@synthesize txtMsngASerEnviada;
@synthesize tabela;
@synthesize scrollAutomatico;

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
	// Do any additional setup after loading the view.
    
    //instanciar o controleRede
    rede = [[ControleRede alloc] initComApelido:_strApelido];
    rede.delegate = self;
    
    lblApelido.text = _strApelido;
    
    arrayMensagens = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [self setLblApelido:nil];
    [self setTxtMsngASerEnviada:nil];
    [self setTabela:nil];
    [self setScrollAutomatico:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sair:(id)sender
{
    [rede desconectar];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)enviar:(id)sender
{
    [rede enviarMensagem:txtMsngASerEnviada.text];
    [txtMsngASerEnviada resignFirstResponder];
        
    NSMutableDictionary *dicMsg = [[NSMutableDictionary alloc] init];
    
    //criando o horario
    NSDateFormatter *formatador = [[NSDateFormatter alloc] init];
    [formatador setDateFormat:@"HH:mm"];
    [dicMsg setObject:[formatador stringFromDate:[NSDate date]] forKey:@"horario"];
    
    [dicMsg setObject:txtMsngASerEnviada.text forKey:@"mensagem"];
    [dicMsg setObject:_strApelido forKey:@"usuario"];
    
    [arrayMensagens addObject:dicMsg];
    
    [tabela reloadData];
    
    if (scrollAutomatico.on)
    {
        //captando o indexPath da ultima linha da tabela
        NSIndexPath *ip = [NSIndexPath indexPathForRow:[arrayMensagens count] - 1 inSection:0];
        
        //mandar a tabela fazer o scroll ate a ultima linha
        [tabela scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    txtMsngASerEnviada.text = @"";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayMensagens count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dicMsg = [arrayMensagens objectAtIndex:indexPath.row];
    
    CelulaMensagem *cell;
    
    if ([_strApelido isEqualToString:[dicMsg objectForKey:@"usuario"]])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"msgInterna"];
    }
    else
    {
       cell = [tableView dequeueReusableCellWithIdentifier:@"msgExterna"]; 
    }

    cell.lblApelido.text = [dicMsg objectForKey:@"usuario"];
    cell.lblMensagem.text = [dicMsg objectForKey:@"mensagem"];
    cell.lblHorario.text = [dicMsg objectForKey:@"horario"];
    
    return cell;
    
}

-(void)recebiTexto:(NSString *)texto doUsuario:(NSString *)usuario
{
    NSMutableDictionary *dicMsg = [[NSMutableDictionary alloc] init];
    
    //criando o horario
    NSDateFormatter *formatador = [[NSDateFormatter alloc] init];
    [formatador setDateFormat:@"HH:mm"];
    [dicMsg setObject:[formatador stringFromDate:[NSDate date]] forKey:@"horario"];
    
    [dicMsg setObject:texto forKey:@"mensagem"];
    [dicMsg setObject:usuario forKey:@"usuario"];
    
    [arrayMensagens addObject:dicMsg];
    
    [tabela reloadData];
    
    if (scrollAutomatico.on)
    {
        //captando o indexPath da ultima linha da tabela
        NSIndexPath *ip = [NSIndexPath indexPathForRow:[arrayMensagens count] - 1 inSection:0];
        
        //mandar a tabela fazer o scroll ate a ultima linha
        [tabela scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}



@end
