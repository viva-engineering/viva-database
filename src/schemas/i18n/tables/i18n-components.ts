
import { DatabaseTable } from '../../schema';

export const i18nComponents = new DatabaseTable('i18n_components', {
	code: 'code' as const,
	description: 'description' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
