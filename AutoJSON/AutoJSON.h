//
//  AutoJSON.h
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double AutoJSONVersionNumber;
FOUNDATION_EXPORT const unsigned char AutoJSONVersionString[];

NS_SWIFT_NAME(AutoJSON)
@interface N7AutoJSON : NSObject

- (nonnull instancetype)initWithContent:(nullable id)content;

+ (nullable N7AutoJSON *)fromData:(nonnull NSData *)data;

@property (nonnull, nonatomic, readonly) NSArray<N7AutoJSON *> *jsonArray;
@property (nonnull, nonatomic, readonly) NSArray<NSString *> *allKeys;

@property (nullable, nonatomic, readonly) NSNumber *number;
@property (nullable, nonatomic, readonly) NSString *string;

@property (nonnull, nonatomic, readonly) NSString *stringValue;
@property (nonatomic, readonly) BOOL boolValue;
@property (nonatomic, readonly) double doubleValue;

- (BOOL)exists;
- (nonnull N7AutoJSON *)either:(nonnull N7AutoJSON *)json;

- (nonnull N7AutoJSON *)objectAtIndexedSubscript:(NSUInteger)idx;
- (nonnull N7AutoJSON *)objectForKeyedSubscript:(nonnull NSString *)key;

@end
