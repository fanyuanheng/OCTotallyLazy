#import "Some.h"
#import "LazySequence.h"
#import "SingleValueEnumerator.h"

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

- (id <Enumerable>)flatten {
    return [[self asSequence] flatten];
}

- (id)get {
    return value;
}

- (id)getOrElse:(id)other {
    return value;
}

- (id)getOrInvoke:(id (^)())funcBlock {
    return value;
}

- (id)map:(id (^)(id))funcBlock {
    return [Some some:funcBlock(value)];
}

- (id)fold:(id)seed with:(id (^)(id, id))functorBlock {
    return [Some some:functorBlock(seed, value)];
}

- (LazySequence *)asSequence {
    return lazySequence(value, nil);
}

- (NSEnumerator *)toEnumerator {
    return [SingleValueEnumerator singleValue:value];
}

- (void)dealloc {
    [value release];
    [super dealloc];
}

@end