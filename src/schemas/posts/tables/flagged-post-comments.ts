
import { DatabaseTable } from '../../schema';

export const flaggedPostComments = new DatabaseTable('flagged_post_comments', {
	postCommentId: 'post_comment_id' as const,
	userId: 'user_id' as const,
	reason: 'reason' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
