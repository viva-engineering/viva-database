
import { DatabaseTable } from '../../schema';

export const flaggedPosts = new DatabaseTable('flagged_posts', {
	postId: 'post_id' as const,
	userId: 'user_id' as const,
	reason: 'reason' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
