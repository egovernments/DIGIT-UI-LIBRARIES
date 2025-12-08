import { openDB } from 'idb';

const DB_NAME = 'LocalizationDB';
const STORE_NAME = 'translations';
const DB_VERSION = 1;

const dbPromise = openDB(DB_NAME, DB_VERSION, {
  upgrade(db) {
    if (!db.objectStoreNames.contains(STORE_NAME)) {
      const store = db.createObjectStore(STORE_NAME, { keyPath: 'key' });
      store.createIndex('locale', 'locale');
    }
  },
}).catch(err => {
  console.error('Failed to open IndexedDB:', err);
});


export const IndexedDbStorage = {
  async set(key, value, ttlInSeconds = null) {
    const db = await dbPromise;
    const expiry = ttlInSeconds ? Date.now() + ttlInSeconds * 1000 : null;
    await db.put(STORE_NAME, { key, value, expiry, createdAt: Date.now() });
  },

  async get(key) {
    const db = await dbPromise;
    const record = await db.get(STORE_NAME, key);
    if (!record) return null;

    // check expiry
    if (record.expiry && Date.now() > record.expiry) {
      await db.delete(STORE_NAME, key);
      return null;
    }
    return record.value;
  },

  async remove(key) {
    const db = await dbPromise;
    await db.delete(STORE_NAME, key);
  },

  async clearAll() {
    const db = await dbPromise;
    await db.clear(STORE_NAME);
  },

  async keys() {
    const db = await dbPromise;
    return (await db.getAllKeys(STORE_NAME)) || [];
  },
};