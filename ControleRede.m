//
//  ControleRede.m
//  Chat
//
//  Created by Rafael Brigagão Paulino on 08/10/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "ControleRede.h"

@interface ControleRede()
{
    GKSession *gerenciadorSessao;
}

@end

@implementation ControleRede

#pragma mark Construtor da classe

-(id)initComApelido:(NSString*)apelido
{
    self = [super init];
    
    if (self != nil)
    {
        //e como se nos estivessemos na sala
        gerenciadorSessao = [[GKSession alloc] initWithSessionID:@"chatIAI" displayName:apelido sessionMode:GKSessionModePeer];
        gerenciadorSessao.available = YES;
        
        //dizendo para o gerenciador sessao que iremos captar os eventos nao relacionados a dados que ocorrer dentro dele
        gerenciadorSessao.delegate = self;
        
        //setando o delegate que é utilizado para dados
        [gerenciadorSessao setDataReceiveHandler:self withContext:nil];
        
    }
    return self;
}

//metodo acionado quando chega dados pela rede
- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    NSString *mensagemRecebida = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //nos mostramos o nome do usuario que enviou o a mensagem
    //captar quem enviou a mensagem
    NSString *nomeUsuario = [gerenciadorSessao displayNameForPeer:peer];
    
    //avisar a tela de que chegou a mensagem
    [_delegate recebiTexto:mensagemRecebida doUsuario:nomeUsuario];
}

//metodo acionado quando muda o estado de um usuario da sala
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    //pega o nome do usuario
    NSString *nomeUsuario = [gerenciadorSessao displayNameForPeer:peerID];
    
    //se o usuario ficar disponivel
    if (state == GKPeerStateAvailable)
    {
        //nos conecatamos com ele
        [gerenciadorSessao connectToPeer:peerID withTimeout:7];
    }
    //estado conectado
    else if (state == GKPeerStateConnected)
    {
        //avisar a nossa tela que alguem entrou na sala
        [_delegate recebiTexto:@"entrou na sala" doUsuario:nomeUsuario];
    }
    //saiu da sala
    else if (state == GKPeerStateDisconnected)
    {
        //avisar a tela que o usuario saiu da sala
        [_delegate recebiTexto:@"saiu da sala" doUsuario:nomeUsuario];
    }
    
}

//metodo acionado quando recebemos um pedido de conexao de um usuario
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    //aceita o pedido de  conexao do usuario
    [gerenciadorSessao acceptConnectionFromPeer:peerID error:nil];
    
    //rejeita o pedido de conexao
    //[gerenciadorSessao denyConnectionFromPeer:peerID error:nil];
}

-(void)enviarMensagem:(NSString*)msg
{
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    //tenta enviar a msn até conseguir: withDataMode:GKSendDataReliable
    [gerenciadorSessao sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}

-(void)desconectar
{
    [gerenciadorSessao disconnectFromAllPeers];
    gerenciadorSessao = nil;
}


@end
