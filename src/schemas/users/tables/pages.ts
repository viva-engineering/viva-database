
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface PagesColumns {
	id: number;
	owner_user_id: number;
	explicit_content: Bit;
	lock_explicit_content: Bit;
	is_private: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const pages = new DatabaseTable('pages', {
	id: 'id' as const,
	ownerUserId: 'owner_user_id' as const,
	explicitContent: 'explicit_content' as const,
	lockExplicitContent: 'explicit_content' as const,
	isPrivate: 'is_private' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
