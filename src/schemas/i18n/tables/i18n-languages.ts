
import { DatabaseTable } from '../../schema';

export const i18nLanguages = new DatabaseTable('i18n_languages', {
	code: 'code' as const,
	description: 'description' as const,
	nativeDescription: 'native_description' as const,
	active: 'active' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
