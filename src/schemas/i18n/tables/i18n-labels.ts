
import { DatabaseTable } from '../../schema';

export const i18nLabels = new DatabaseTable('i18n_labels', {
	code: 'code' as const,
	componentCode: 'component_code' as const,
	description: 'description' as const,
	createdTimestamp: 'created_timestamp' as const,
	updatedTimestamp: 'updated_timestamp' as const
});
