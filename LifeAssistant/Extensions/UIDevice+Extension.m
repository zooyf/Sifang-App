//
//  UIDevice+Extension.m
//  iOSShare
//
//  Created by wujin on 13-5-7.
//  Copyright (c) 2013年 wujin. All rights reserved.
//

#import "UIDevice+Extension.h"
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#include "OpenUDID.h"

#import "NSString+Extension.h"

#import <CommonCrypto/CommonDigest.h>
//#import <AdSupport/AdSupport.h>

BOOL DeviceSystemSmallerThan(float version)
{
	static float flag=-1;
	if (flag==-1) {
		flag=[[[UIDevice currentDevice] systemVersion] floatValue];
	}
	return flag<version;
}
BOOL DeviceIsiPhone5OrLater()
{
	static int flag=-1;
	if (flag==-1) {
		flag=[UIScreen mainScreen].bounds.size.height>480;
	}
	return flag;
}
BOOL DeviceIsiPad()
{
	__block BOOL isipad=NO;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		isipad=[UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad;
	});
	return isipad;
}

BOOL DeviceIsiPhone()
{
	__block BOOL isiphone=NO;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		isiphone=[UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone;
	});
	return isiphone;
}

UIKIT_EXTERN BOOL DeviceIsLarge()
{
    static int flag=-1;
    if (flag==-1) {
        flag=[UIScreen mainScreen].bounds.size.width>320;
    }
    return flag;
}

UIKIT_EXTERN NSUInteger DeviceSystemMajorVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    
    return _deviceSystemMajorVersion;
}

UIKIT_EXTERN NSString* mydeviceUniqueIdentifier()
{
    static  NSString *uniqueIdentifier = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uniqueIdentifier = [UIDevice uniqueOpenIdentifier];
    });
    
    return uniqueIdentifier;
}

@implementation UIDevice (Extension)

+ (NSString *)macAddress
{
    if (DeviceSystemSmallerThan(7.0)==NO) {
//        DLog(@"iOS7.0 or Later can't get the mac adress");
    }
    
    int                     mib[6];
    size_t                  len;
    char                    *buf;
    unsigned char           *ptr;
    struct if_msghdr        *ifm;
    struct sockaddr_dl      *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0)
    {
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL)
    {
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0)
    {
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return outstring;
}

+ (NSString*) uniqueOpenIdentifier
{
    NSString* uniqueIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_slot_open_udid_kz"];
    if (!uniqueIdentifier) {
        uniqueIdentifier = [OpenUDID value];
        if (uniqueIdentifier==nil) {
            uniqueIdentifier = @"0000";
        }
        uniqueIdentifier = [uniqueIdentifier md5DecodingString];
        
        [[NSUserDefaults standardUserDefaults] setObject:uniqueIdentifier forKey:@"device_slot_open_udid_kz"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return uniqueIdentifier;
}

+ (NSString*) uniqueAdvertisingIdentifier
{
    NSString* openUDID = [OpenUDID value];
    
    if (openUDID==nil) {
        openUDID = @"0000";
    }
    
    
    NSString *uniqueIdentifier = [openUDID md5DecodingString];
    
    return uniqueIdentifier;
}

+ (NSString*) uniqueGlobalDeviceIdentifier
{
    NSString *macaddress = [UIDevice macAddress];
    if (!macaddress || [macaddress length]<1) {
        macaddress = @"0";
    }
    NSString *uniqueIdentifier = [macaddress md5DecodingString];
    
    return uniqueIdentifier;
}
//+ (NSString*) uniqueIDFAIdentifier
//{
//    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    
//}

@end
