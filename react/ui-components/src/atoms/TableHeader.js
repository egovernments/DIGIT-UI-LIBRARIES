import React from 'react';

export const TableHeader = ({ children,className,style }) => {
  return (
    <thead className={className} style={style}>
      {children}
    </thead>
  );
};
