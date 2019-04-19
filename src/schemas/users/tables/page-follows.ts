
import { DatabaseTable } from '../../schema';

export const pagesFollows = new DatabaseTable('page_follows', {
	pageId: 'page_id' as const,
	userId: 'user_id' as const,
	approved: 'approved' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
