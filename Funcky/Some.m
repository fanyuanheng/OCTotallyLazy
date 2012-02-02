#import "Some.h"

@implementation Some {
    id <NSObject> value;
}

-(Option *)initWithValue:(id <NSObject>)aValue {
    self = [super init];
    value = [aValue retain];
    return self;
}

+ (Option *)some:(id)value {
    return [[[Some alloc] initWithValue: value] autorelease];
}

- (BOOL)isEqual:(id)otherObject {
    if (![otherObject isKindOfClass:[Some class]]) {
        return FALSE;
    }
    return [[otherObject get] isEqual:[self get]];
}

- (id)get {
    return value;
}

- (BOOL)isEmpty {
    return FALSE;
}

- (id)map:(id (^)(id))funcBlock {
    return [Some some:funcBlock(value)];
}

- (id)fold:(id)seed with:(id (^)(id, id))functorBlock {
    return [Some some:functorBlock(seed, value)];
}

- (void)dealloc {
    [value release];
    [super dealloc];
}

@end