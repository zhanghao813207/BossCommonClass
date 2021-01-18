#import "PreviewModel.h"

#pragma mark -PreviewModel
@implementation PreviewModel

- (void)setValue:(id)value forKey:(NSString *)key{
	if ([value isKindOfClass:[NSNumber class]]) {
		[self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
	}else{
		[super setValue:value forKey:key];
	}
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

-(id)valueForUndefinedKey:(NSString *)key{
	NSLog(@"error: PreviewModel数据模型中:未找到key = %@",key);
	return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
	[aCoder encodeObject:self.fileName forKey:@"fileName"];
	[aCoder encodeObject:self.fileId forKey:@"fileId"];
	[aCoder encodeObject:self.saveTime forKey:@"saveTime"];
	[aCoder encodeObject:self.filePath forKey:@"filePath"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super init]) {
		self.fileName = [aDecoder decodeObjectForKey:@"fileName"];
		self.fileId = [aDecoder decodeObjectForKey:@"fileId"];
		self.saveTime = [aDecoder decodeObjectForKey:@"saveTime"];
		self.filePath = [aDecoder decodeObjectForKey:@"filePath"];
	}
	return self;
}

- (NSString *)description{
	return [NSString stringWithFormat:@"fileName=%@,fileId=%@,saveTime=%@,filePath=%@",_fileName,_fileId,_saveTime,_filePath];
}

@end

