
import { Bit, TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface PageFollowsColumns {
	page_id: number;
	user_id: number;
	approved: Bit;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const pageFollows = new DatabaseTable('page_follows', {
	pageId: 'page_id' as const,
	userId: 'user_id' as const,
	approved: 'approved' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
