import React from 'react';

const TableMain = ({ children,className,style}) => {
  return (
    <table className={className} style={style}>
      {children}
    </table>
  );
};

export default TableMain;
