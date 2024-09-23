import React from 'react';

export const TableBody = ({ children,style }) => {
  return (
    <tbody style={style}>
      {children}
    </tbody>
  );
};
