
import { TimestampString } from '../../../types';
import { DatabaseTable, ColumnList } from '../../schema';

export interface FriendsColumns {
	user_id_a: number;
	user_id_b: number;
	created_timestamp: TimestampString;
	updated_timestamp: TimestampString;
}

export const friends = new DatabaseTable('friends', <ColumnList<FriendsColumns>> {
	userA: 'user_id_a' as const,
	userB: 'user_id_b' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
