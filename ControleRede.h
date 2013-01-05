//
//  ControleRede.h
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol ControleRedeDelegate <NSObject>

@required
-(void)recebiTexto:(NSString*)texto doUsuario:(NSString*)usuario;

@end

@interface ControleRede : NSObject <GKSessionDelegate>

@property (nonatomic, weak) id<ControleRedeDelegate> delegate;

-(id)initComApelido:(NSString*)apelido;
-(void)enviarMensagem:(NSString*)msg;
-(void)desconectar;

@end
