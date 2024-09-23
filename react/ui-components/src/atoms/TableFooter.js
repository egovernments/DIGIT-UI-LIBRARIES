import React from 'react';

export const TableFooter = ({ children ,className,style}) => {
  return (
    <tfoot className={className} style={style}>
      {children}
    </tfoot>
  );
};
