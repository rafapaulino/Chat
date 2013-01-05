//
//  CelulaMensagem.h
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CelulaMensagem : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblApelido;
@property (nonatomic, strong) IBOutlet UILabel *lblMensagem;
@property (nonatomic, strong) IBOutlet UILabel *lblHorario;

@end
