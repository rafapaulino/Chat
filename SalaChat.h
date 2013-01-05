//
//  SalaChat.h
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControleRede.h"
#import "CelulaMensagem.h"

@interface SalaChat : UIViewController <UITableViewDataSource,UITableViewDelegate,ControleRedeDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblApelido;
@property (weak, nonatomic) IBOutlet UITextField *txtMsngASerEnviada;
@property (nonatomic, strong) NSString *strApelido;


@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (weak, nonatomic) IBOutlet UISwitch *scrollAutomatico;

- (IBAction)sair:(id)sender;
- (IBAction)enviar:(id)sender;


@end
