import React from 'react';

export const TableRow = ({ children ,className,onClick}) => {
  return (
    <tr className={className} onClick={onClick}>
      {children}
    </tr>
  );
};
