
import { DatabaseTable } from '../../schema';

export const pages = new DatabaseTable('pages', {
	id: 'id' as const,
	ownerUserId: 'owner_user_id' as const,
	explicitContent: 'explicit_content' as const,
	lockExplicitContent: 'explicit_content' as const,
	isPrivate: 'is_private' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
