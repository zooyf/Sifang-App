//
//  NSURL+Extension.m
//  iOSShare
//
//  Created by wujin on 13-4-19.
//  Copyright (c) 2013年 wujin. All rights reserved.
//

#import "NSURL+Extension.h"
#import <netdb.h>
#import <arpa/inet.h>

@implementation NSURL (Extension)

-(NSDictionary*)paramDictionary
{
    NSString *paramstr=self.query;
    NSArray *split=[paramstr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
     NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES .=."];
    for (NSString *str in split) {
        if ([numberPre evaluateWithObject:str]) {
            NSArray *str_split=[str componentsSeparatedByString:@"="];
            if (str_split.count==2) {
                [dic setValue:[str_split objectAtIndex:1] forKey:[str_split objectAtIndex:0]];
            }
        }
    }
    return dic;
}

-(NSString*)valueForParam:(NSString *)param
{
    return [self.paramDictionary valueForKey:param];
}

- (NSMutableArray *)lookIpForURL
{
    NSMutableArray *tempDNS = [[NSMutableArray alloc] init];
    
    @try {
        CFHostRef hostRef = CFHostCreateWithName(kCFAllocatorDefault, (__bridge CFStringRef)[self host]);
        if (hostRef)
        {
            Boolean result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
            if (result == TRUE)
            {
                NSArray *addresses = (__bridge NSArray*)CFHostGetAddressing(hostRef, &result);
                
                if (addresses) {
                    for(int i = 0; i < addresses.count; i++)
                    {
                        struct sockaddr_in* remoteAddr;
                        CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex((__bridge CFArrayRef)addresses, i);
                        remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
                        
                        if(remoteAddr != NULL)
                        {
                            const char *strIP41 = inet_ntoa(remoteAddr->sin_addr);
                            
                            NSString *strDNS =[NSString stringWithCString:strIP41 encoding:NSASCIIStringEncoding];
                            //DLog(@"RESOLVED %d:<%@>", i, strDNS);
                            if (strDNS) {
                                [tempDNS addObject:strDNS];
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
    @catch (NSException *exception) {
        
    }
  
    
    return tempDNS;
}

@end
