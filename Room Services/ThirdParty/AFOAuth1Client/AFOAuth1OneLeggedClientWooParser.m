//
//  AFOAuth1OneLeggedClientWooParser.m
//  OrangeFashion
//
//  Created by Triệu Khang on 20/6/14.
//  Copyright (c) 2014 Triệu Khang. All rights reserved.
//

#import "AFOAuth1OneLeggedClientWooParser.h"
#import "AFOAuth1OneLeggedClient.h"

@interface AFOAuth1OneLeggedClientWooParser()
<
AFOAuth1OneLeggedClientWooParserProtocol
>

@end

@implementation AFOAuth1OneLeggedClientWooParser

- (NSMutableArray *)wooCommerceParsedResponseObject:(id)responseObject {
    BOOL isData = [responseObject isKindOfClass:[NSData class]];
    
    if (!isData) {
        NSLog(@"The response object is not correct type ( shoud be NSData )");
        return @{};
    }
    
    NSError *error = nil;
    
    NSMutableArray *returnArray = [NSMutableArray array];
    NSArray *array = [NSArray array];
    //    NSDictionary *dictionnary;
    
    NSMutableArray* dictionnary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
    
    
    if ([dictionnary isKindOfClass:[NSDictionary class]]) {
        
        dictionnary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        [returnArray addObject:dictionnary];
        
        
        
    }else{
        array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        returnArray = [NSMutableArray arrayWithArray:array];
    }
    
    
    
    
    //    NSLog(@"Response Meta: %@", dict);
    //
    //    NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //    NSRange range = [jsonString rangeOfString:@"{"];
    //    if (range.location != NSNotFound) {
    //        jsonString = [jsonString substringFromIndex:range.location];
    //    }
    //
    //    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //    NSDictionary *dictionnary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //
    //    BOOL isDictionary = [dictionnary isKindOfClass:[NSDictionary class]];
    //    if (!isDictionary) {
    //        NSLog(@"The parsed response object is not correct type ( shoud be NSDictionary )");
    //        return @{};
    //    }
    
    return returnArray;
}

@end
