
import { DatabaseTable } from '../../schema';

export const moderatorNotes = new DatabaseTable('moderator_notes', {
	id: 'id' as const,
	userId: 'user_id' as const,
	note: 'note' as const,
	addedBy: 'added_by' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
