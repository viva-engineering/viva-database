
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface FlaggedPostCommentsColumns {
	post_comment_id: number;
	user_id: number;
	reason: string;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const flaggedPostComments = new DatabaseTable('flagged_post_comments', <ColumnList<FlaggedPostCommentsColumns>> {
	postCommentId: 'post_comment_id' as const,
	userId: 'user_id' as const,
	reason: 'reason' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
