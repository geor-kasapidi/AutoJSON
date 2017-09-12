//
//  N7AutoJSON.m
//

#import "AutoJSON.h"

@interface N7AutoJSON ()

@property (strong, nonatomic) id content;

@end

@implementation N7AutoJSON

- (NSString *)description {
    id content = self.content;

    if (content != nil && [NSJSONSerialization isValidJSONObject:content]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];

        if (data != nil) {
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

            if (string != nil) {
                return string;
            }
        }
    }

    return self.string ?: @"";
}

- (NSString *)debugDescription {
    return [self description];
}

#pragma mark -

- (instancetype)initWithContent:(id)content {
    self = [super init];

    if (self != nil) {
        _content = content;
    }

    return self;
}

+ (N7AutoJSON *)fromData:(NSData *)data {
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    if (json != nil && [NSJSONSerialization isValidJSONObject:json]) {
        return [[N7AutoJSON alloc] initWithContent:json];
    }

    return nil;
}

#pragma mark -

- (NSArray<N7AutoJSON *> *)jsonArray {
    NSMutableArray *items = [NSMutableArray new];

    if ([self.content isKindOfClass:[NSArray class]]) {
        [self.content enumerateObjectsUsingBlock:^(id obj, NSUInteger _, BOOL *__) {
            N7AutoJSON *item = [[N7AutoJSON alloc] initWithContent:obj];

            [items addObject:item];
        }];
    }

    return [items copy];
}

- (NSArray<NSString *> *)allKeys {
    if ([self.content isKindOfClass:[NSDictionary class]]) {
        return [self.content allKeys];
    }
    
    return @[];
}

#pragma mark -

- (NSNumber *)number {
    if ([self.content isKindOfClass:[NSNumber class]]) {
        return self.content;
    }

    return nil;
}

- (NSString *)string {
    if ([self.content isKindOfClass:[NSString class]]) {
        return self.content;
    }

    return self.number.stringValue;
}

#pragma mark -

- (NSString *)stringValue {
    return self.string ?: @"";
}

- (BOOL)boolValue {
    return [self.number boolValue];
}

- (double)doubleValue {
    return [self.number doubleValue];
}

#pragma mark -

- (BOOL)exists {
    if ([self.content isKindOfClass:[NSNull class]]) {
        return NO;
    }

    return self.content != nil;
}

- (N7AutoJSON *)either:(N7AutoJSON *)json {
    if ([self exists]) {
        return self;
    }

    return json;
}

#pragma mark -

- (N7AutoJSON *)objectAtIndexedSubscript:(NSUInteger)idx {
    N7AutoJSON *item = [N7AutoJSON new];

    if ([self.content isKindOfClass:[NSArray class]] && idx < [self.content count]) {
        item.content = self.content[idx];
    }

    return item;
}

- (N7AutoJSON *)objectForKeyedSubscript:(NSString *)key {
    N7AutoJSON *item = [N7AutoJSON new];

    if ([self.content isKindOfClass:[NSDictionary class]]) {
        item.content = self.content[key];
    }
    
    return item;
}

@end
