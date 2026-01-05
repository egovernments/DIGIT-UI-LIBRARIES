import { openDB } from 'idb';

const DB_NAME = 'LocalizationDB';
const STORE_NAME = 'translations';
const DB_VERSION = 1;

let dbInstance = null;
let dbInitPromise = null;

const initDb = async () => {
  if (dbInstance) return dbInstance;

  if (dbInitPromise) return dbInitPromise;

  dbInitPromise = (async () => {
    try {
      dbInstance = await openDB(DB_NAME, DB_VERSION, {
        upgrade(db) {
          if (!db.objectStoreNames.contains(STORE_NAME)) {
            const store = db.createObjectStore(STORE_NAME, { keyPath: 'key' });
            store.createIndex('locale', 'locale');
          }
        },
      });
      return dbInstance;
    } catch (err) {
      console.error('Failed to open IndexedDB:', err);
      dbInitPromise = null;
      return null;
    }
  })();

  return dbInitPromise;
};

export const IndexedDbStorage = {
  async set(key, value, ttlInSeconds = null) {
    try {
      const db = await initDb();
      if (!db) {
        console.warn('IndexedDB unavailable, skipping cache set for:', key);
        return;
      }
      const expiry = ttlInSeconds ? Date.now() + ttlInSeconds * 1000 : null;
      await db.put(STORE_NAME, { key, value, expiry, createdAt: Date.now() });
    } catch (err) {
      console.error('IndexedDB set error for key:', key, err);
    }
  },

  async get(key) {
    try {
      const db = await initDb();
      if (!db) {
        console.warn('IndexedDB unavailable, returning null for:', key);
        return null;
      }
      const record = await db.get(STORE_NAME, key);
      if (!record) return null;

      if (record.expiry && Date.now() > record.expiry) {
        await db.delete(STORE_NAME, key);
        return null;
      }
      return record.value;
    } catch (err) {
      console.error('IndexedDB get error for key:', key, err);
      return null;
    }
  },

  async remove(key) {
    try {
      const db = await initDb();
      if (!db) return;
      await db.delete(STORE_NAME, key);
    } catch (err) {
      console.error('IndexedDB remove error for key:', key, err);
    }
  },

  async clearAll() {
    try {
      const db = await initDb();
      if (!db) return;
      await db.clear(STORE_NAME);
    } catch (err) {
      console.error('IndexedDB clearAll error:', err);
    }
  },

  async keys() {
    try {
      const db = await initDb();
      if (!db) return [];
      return (await db.getAllKeys(STORE_NAME)) || [];
    } catch (err) {
      console.error('IndexedDB keys error:', err);
      return [];
    }
  },

  isAvailable: async () => {
    const db = await initDb();
    return db !== null;
  },
};
