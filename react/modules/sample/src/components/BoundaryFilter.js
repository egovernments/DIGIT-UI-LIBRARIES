import React, { useEffect, useState } from 'react'
import { MultiSelectDropdown } from '@egovernments/digit-ui-components'
import { CheckBox } from '@egovernments/digit-ui-react-components';
import { useTranslation } from 'react-i18next';

const BoundaryFilter = (lowestLevel) => {
  const hierarchyType = "NEWTEST00222";
  const tenantId = Digit.ULBService.getCurrentTenantId();
  const [lowestHierarchy, setLowestHierarchy] = useState("")
  const t = useTranslation();


  debugger;
  const { data: BOUNDARY_HIERARCHY_TYPE } = Digit.Hooks.useCustomMDMS(tenantId, "HCM-ADMIN-CONSOLE", [{ name: "HierarchySchema" }], {
    select: (data) => {
      const item = data?.["HCM-ADMIN-CONSOLE"]?.HierarchySchema?.find(
        (item) => item.type === "microplan"
      );
      setLowestHierarchy(item.lowestHierarchy)
      console.log("1111 hier",item?.hierarchy)
      return item?.hierarchy
    },
  }, { schemaCode: "BASE_MASTER_DATA_INITIAL" });

  const reqHierarchyData = {
    url: `/boundary-service/boundary-relationships/_search`,
    changeQueryName: `${BOUNDARY_HIERARCHY_TYPE}`,
    params: {
      tenantId: tenantId,
      hierarchyType: hierarchyType,
      includeChildren: true,
      parent
    },
    body: {},
    config: {
      select: (data) => {
        console.log("1111 data", data);
  
        // Recursive function to process hierarchy and attach paths
        const processHierarchy = (nodes, parentPath = "") => {
          return nodes.map((node) => {
            // Construct the current node's full path using its code
            const currentPath = parentPath ? `${parentPath}.${node.code}` : node.code;
  
            // Process children if they exist
            if (node.children && node.children.length > 0) {
              node.children = processHierarchy(node.children, currentPath);
            }
  
            // Attach the path attribute
            return { ...node, path: currentPath };
          });
        };
  
        return processHierarchy(data?.TenantBoundary?.[0]?.boundary)
    }}
  };
  
  const { data: hierarchyData, refetch, isLoading } = Digit.Hooks.useCustomAPIHook(reqHierarchyData);
  

  // const hierarchyData = hierarchyData1;
  // boundaryOptions={
  //   administrative:[{path:administrative.province,code:"XYZ"},{path}]
  // }


  const [boundaryOptions, setBoundaryOptions] = useState({});

  const reqCriteria = {
    url: `/boundary-service/boundary-hierarchy-definition/_search`,
    changeQueryName: `${hierarchyType}`,
    body: {
      BoundaryTypeHierarchySearchCriteria: {
        tenantId: 'dev',
        limit: 2,
        offset: 0,
        hierarchyType: hierarchyType,
      },
    },
    config:{
      select:(data)=>{
        return data?.BoundaryHierarchy[0]?.boundaryHierarchy
      }
    }
  };

  const { isLoading: hierarchyLoading, data: hierarchy } = Digit.Hooks.useCustomAPIHook(reqCriteria);

  useEffect(() => {
    if (hierarchy) {
      console.log("1111 hierarchy", hierarchy);
    }
  }, [hierarchy]);

  useEffect(() => {
    if (BOUNDARY_HIERARCHY_TYPE) {
      console.log("1111 Boundary", BOUNDARY_HIERARCHY_TYPE);
    }
  }, [BOUNDARY_HIERARCHY_TYPE]);

  // useEffect(() => {
  //   if (hierarchyData) {
  //     console.log("1111 hierarchyData", hierarchyData);
  //   }
  // }, [hierarchyData]);

  console.log("byeee");
  const rootBoundaryType = hierarchy?.filter((item) => item?.parentBoundaryType === null)[0]?.boundaryType;
  const lowestIndex = hierarchy?.findIndex((item) => item?.boundaryType === lowestLevel);

  const findNodeByPath = (nodes, targetPath) => {
    console.log("nodes",nodes);
    for (const node of nodes) {
      if (node.path === targetPath) {
        return node.children?.map(child => ({ code: child.code,id:child.id, path: child.path })) || [];
      }
      if (node.children && node.children.length > 0) {
        const result = findNodeByPath(node.children, targetPath);
        if (result) return result; // If found in the recursive call, return result
      }
    }
    return null; // Return null if no match is found
  };
  if(hierarchyData){
    console.log("1111 Node by path",findNodeByPath(hierarchyData,"NEWTEST00222_MO.NEWTEST00222_MO_10_MAPUTO_CITY"));

  }
  const boundaryOptionsUpdate = (boundaryType, values) => {
    // debugger;
    const childBoundaryType = hierarchy.find(
      (item) => item.parentBoundaryType === boundaryType
    )?.boundaryType;
  
    if (!childBoundaryType) return; // If no child boundaryType, exit early
  
    setBoundaryOptions((prev) => {
      const updatedOptions = { ...prev }; // Clone previous state
  
      values.forEach((value) => {
        if (boundaryType !== lowestLevel) {
          const children = findNodeByPath(hierarchyData, value?.path);
  
          if (!updatedOptions[childBoundaryType]) {
            updatedOptions[childBoundaryType] = {}; // Initialize if missing
          }
  
          if (!updatedOptions[childBoundaryType][value?.code]) {
            updatedOptions[childBoundaryType][value?.code] = [];
          }
  
          updatedOptions[childBoundaryType][value?.code] = [
            ...updatedOptions[childBoundaryType][value?.code], 
            ...children
          ];
        }
      });
  
      return updatedOptions; // Return new state object
    });
  };
  
  
  if(hierarchy && hierarchyData){
  boundaryOptionsUpdate( 
    "POSTADMINISTRATIVE", 
    [{path:"NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER",code:"NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER"},
      {path:"NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC",code:"NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC"}]);

    }
    useEffect(() => {
      if (hierarchy && hierarchyData) {
        boundaryOptionsUpdate( 
          "POSTADMINISTRATIVE", 
          [
            {
              path: "NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER",
              code: "NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER"
            },
            {
              path: "NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC",
              code: "NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC"
            }
          ]
        );
      }
    }, [hierarchy, hierarchyData]);

  useEffect(()=>{
    if(!hierarchyData || !hierarchy) return;
    setBoundaryOptions((prev)=>({
      ...prev,
      [rootBoundaryType]:[{code:[{path:hierarchyData[0]?.path,code:hierarchyData[0]?.code,id:hierarchyData[0]?.id}]}]
    }
    ))
  },[hierarchyData,hierarchy])

 

  

  
  
  console.log("1111 hiii1", rootBoundaryType);
  console.log("1111 hierarchyData",hierarchyData);
  console.log("1111 boundary options",boundaryOptions);

  if(boundaryOptions && boundaryOptions[rootBoundaryType]){
    console.log("1111 rootboun",boundaryOptions[rootBoundaryType]);
  }
  return (
    <div>
       {/* {hierarchy?.map((item) => {
        console.log("1111", item);
  
        return (item?.boundaryType === rootBoundaryType) ? (
          <MultiSelectDropdown
            key={item?.boundaryType}
            clearLabel="Clear All"
            options={boundaryOptions[rootBoundaryType]}
            optionsKey={"name"}
            t={t}
            onSelect={(values) => {
              boundaryOptionsUpdate(item?.boundaryType, values);
            }}
            type="multiselectdropdown"
            variant="nestedmultiselect"
          />)
         : (() => {
          const boundaries = boundaryOptions[item?.boundaryType];
  
          if (boundaries) {
            const formattedOptions = Object.keys(boundaries).map((parentKey) => ({
              code: parentKey,
              name: parentKey,
              options: boundaries[parentKey].map((child) => ({
                code: child.code,
                name: child.code, // Using child's code as name as requested
              })),
            }));
  
            return (
              <MultiSelectDropdown
                key={item?.boundaryType}
                clearLabel="Clear All"
                options={formattedOptions}
                optionsKey={"name"}
                t={t}
                onSelect={(values) => {
                  boundaryOptionsUpdate(item?.boundaryType, values);
                }}
                type="multiselectdropdown"
                variant="nestedmultiselect"
              />
            );
          }
  
          return null; // Avoids rendering errors when `boundaries` is undefined
        })();
        
      })}  */}
      <div>hi</div>
    </div>
 

 
);
  
}

export default BoundaryFilter