
import { db } from './index';
import { WriteQuery as BaseWriteQuery, WriteQueryResult, SelectQuery as BaseSelectQuery, SelectQueryResult } from '@viva-eng/database';
import { MysqlError, raw, format, PoolConnection } from 'mysql';

export abstract class WriteQuery<P> extends BaseWriteQuery<P> {
	protected readonly prepared: string;

	async run(params: P, connection?: PoolConnection) : Promise<WriteQueryResult> {
		const result = connection
			? await db.runQuery(connection, this, params) as WriteQueryResult
			: await db.query(this, params) as WriteQueryResult;

		return result;
	}
}

export abstract class SelectQuery<P, R> extends BaseSelectQuery<P, R> {
	async run(params: P, connection?: PoolConnection) : Promise<R[]> {
		const result = connection
			? await db.runQuery(connection, this, params) as SelectQueryResult<R>
			: await db.query(this, params) as SelectQueryResult<R>;

		return result.results;
	}
}
