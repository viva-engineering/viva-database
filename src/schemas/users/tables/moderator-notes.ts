
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface ModeratorNotesColumns {
	id: number;
	user_id: number;
	note: string;
	added_by: number;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const moderatorNotes = new DatabaseTable('moderator_notes', {
	id: 'id' as const,
	userId: 'user_id' as const,
	note: 'note' as const,
	addedBy: 'added_by' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
