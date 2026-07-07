/**
 * FieldRows — repeating "selector | value" editor.
 *
 * Form auth needs the user to provide a map of CSS selectors → values
 * to fill in. The natural UX is a table they can add/remove rows in.
 *
 * Each row is `{ id, selector, value }`. The parent owns the array;
 * this component is a controlled list.
 *
 * Presets: a small popover lets the user click "Username", "Password",
 * etc. to insert a row pre-filled with the most common selector. This
 * is the main UX accelerator — most people will use it instead of
 * typing.
 *
 * Props:
 *   - rows: Array<{ id, selector, value }>
 *   - onChange: (newRows) => void
 *   - addPresets?: array of { label, selector, valuePlaceholder, type }
 *   - valueType?: 'text' | 'password'  (default per row; presets can override)
 */

const DEFAULT_PRESETS = [
  { label: 'Username',  selector: 'input[type="text"]',     placeholder: 'e.g. EMPLOYEE',   type: 'text' },
  { label: 'Password',  selector: 'input[type="password"]', placeholder: 'e.g. eGov@123',   type: 'password' },
  { label: 'Email',     selector: 'input[type="email"]',    placeholder: 'user@example.com', type: 'text' },
];

let __rowSeq = 0;
function nextRowId() {
  __rowSeq += 1;
  return `row_${Date.now().toString(36)}_${__rowSeq}`;
}

export function makeRow(selector = '', value = '', type = 'text') {
  return { id: nextRowId(), selector, value, type };
}

export function FieldRows({ rows, onChange, addPresets = DEFAULT_PRESETS }) {
  const update = (id, patch) => {
    onChange(rows.map((r) => (r.id === id ? { ...r, ...patch } : r)));
  };

  const remove = (id) => {
    onChange(rows.filter((r) => r.id !== id));
  };

  const addBlank = () => {
    onChange([...rows, makeRow()]);
  };

  const addPreset = (preset) => {
    onChange([...rows, makeRow(preset.selector, '', preset.type)]);
  };

  return (
    <div className="space-y-2">
      {rows.length === 0 && (
        <p className="text-xs text-slate-500 italic">
          No fields yet. Add one from the presets below, or paste a custom CSS selector.
        </p>
      )}

      {rows.map((row, i) => (
        <div key={row.id} className="flex items-start gap-2">
          <div className="flex-1 grid grid-cols-2 gap-2">
            <div>
              {i === 0 && <label className="block text-[10px] uppercase tracking-wide text-slate-500 mb-1">Selector</label>}
              <input
                type="text"
                value={row.selector}
                onChange={(e) => update(row.id, { selector: e.target.value })}
                placeholder='input[type="text"]'
                className="w-full px-3 py-1.5 text-sm font-mono border border-slate-300 rounded-md focus:border-brand-500 focus:ring-1 focus:ring-brand-500"
                aria-label={`Field ${i + 1} selector`}
              />
            </div>
            <div>
              {i === 0 && <label className="block text-[10px] uppercase tracking-wide text-slate-500 mb-1">Value to fill</label>}
              <input
                type={row.type === 'password' ? 'password' : 'text'}
                value={row.value}
                onChange={(e) => update(row.id, { value: e.target.value })}
                placeholder={row.type === 'password' ? 'password' : 'value'}
                className="w-full px-3 py-1.5 text-sm border border-slate-300 rounded-md focus:border-brand-500 focus:ring-1 focus:ring-brand-500"
                aria-label={`Field ${i + 1} value`}
              />
            </div>
          </div>
          <button
            type="button"
            onClick={() => remove(row.id)}
            aria-label={`Remove field ${i + 1}`}
            className={`text-slate-400 hover:text-red-600 transition-colors flex-shrink-0 ${i === 0 ? 'mt-6' : 'mt-1'}`}
          >
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M3 6h18M8 6V4a2 2 0 012-2h4a2 2 0 012 2v2m3 0v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6h14z" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </button>
        </div>
      ))}

      <div className="flex flex-wrap items-center gap-1.5 pt-1">
        <span className="text-xs text-slate-500 mr-1">Add field:</span>
        {addPresets.map((p) => (
          <button
            key={p.label}
            type="button"
            onClick={() => addPreset(p)}
            className="px-2 py-1 text-xs rounded-md bg-slate-100 hover:bg-slate-200 text-slate-700 transition-colors"
          >
            + {p.label}
          </button>
        ))}
        <button
          type="button"
          onClick={addBlank}
          className="px-2 py-1 text-xs rounded-md bg-slate-100 hover:bg-slate-200 text-slate-700 transition-colors"
        >
          + Custom
        </button>
      </div>
    </div>
  );
}
