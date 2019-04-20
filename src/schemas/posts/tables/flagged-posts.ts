
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface FlaggedPostsColumns {
	post_id: number;
	user_id: number;
	reason: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const flaggedPosts = new DatabaseTable('flagged_posts', <ColumnList<FlaggedPostsColumns>> {
	postId: 'post_id' as const,
	userId: 'user_id' as const,
	reason: 'reason' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
