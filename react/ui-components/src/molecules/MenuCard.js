import React from "react";
import PropTypes from "prop-types";
import { Card, StringManipulator } from "../atoms";
import { iconRender } from "../utils/iconRender";
import { Colors } from "../constants/colors/colorconstants";

const MenuCard = ({
  icon,
  menuName,
  className,
  styles,
  description,
  onClick,
}) => {
  const primaryIconColor = Colors.lightTheme.primary[1];

  return (
    <Card
      className={`digit-menu-card ${className}`}
      style={styles}
      onClick={onClick}
    >
      <div className={`icon-menu-header`}>
        {icon && (
          <div className={`digit-menucard-icon`}>
            {iconRender(
              icon,
              primaryIconColor,
              "40px",
              "40px",
              `digit-menucard-icon`
            )}
          </div>
        )}
        {menuName && (
          <div className="digit-menuacard-menuName">
            {StringManipulator(
              "TOSENTENCECASE",
              StringManipulator("TRUNCATESTRING", menuName, {
                maxLength: 64,
              })
            )}
          </div>
        )}
      </div>
      {description && (
        <div className="digit-menucard-description">
          {StringManipulator(
            "TOSENTENCECASE",
            StringManipulator("TRUNCATESTRING", description, {
              maxLength: 256,
            })
          )}
        </div>
      )}
    </Card>
  );
};

MenuCard.propTypes = {
  icon: PropTypes.node.isRequired,
  menuName: PropTypes.string.isRequired,
  description: PropTypes.string,
  className: PropTypes.string,
  styles: PropTypes.object,
  onClick: PropTypes.func,
};

MenuCard.defaultProps = {
  className: "",
  styles: {},
  menuName: "",
  description: "",
  icon: "",
  onClick: () => {},
};

export default MenuCard;
