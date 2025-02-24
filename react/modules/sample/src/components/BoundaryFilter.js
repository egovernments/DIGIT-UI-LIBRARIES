import React, { useEffect, useState} from 'react'
import { CardText, MultiSelectDropdown } from '@egovernments/digit-ui-components'
import { CheckBox } from '@egovernments/digit-ui-react-components';
import { useTranslation } from 'react-i18next';
import { LabelFieldPair,CardLabel } from "@egovernments/digit-ui-components";

const BoundaryFilter = (props) => {
  const hierarchyType = "NEWTEST00222";
  console.log("props",props);
  const tenantId = Digit.ULBService.getCurrentTenantId();
  const [lowestHierarchy, setLowestHierarchy] = useState("")
  const [nonEditableHierarchies,setNonEditableHierarchies]=useState(new Set())
  const {t} = useTranslation();

//   const preHierarchy=[
//     {
//         "id": "2ccdd169-cb29-412c-a41c-a50ccb9d14e4",
//         "tenantId": "mz",
//         "hierarchyType": "MICROPLAN",
//         "boundaryHierarchy": [
//             {
//                 "boundaryType": "COUNTRY",
//                 "parentBoundaryType": null,
//                 "active": true
//             },
//             {
//                 "boundaryType": "PROVINCE",
//                 "parentBoundaryType": "COUNTRY",
//                 "active": true
//             },
//             {
//                 "boundaryType": "DISTRICT",
//                 "parentBoundaryType": "PROVINCE",
//                 "active": true
//             },
//             {
//                 "boundaryType": "ADMINISTRATIVEPOST",
//                 "parentBoundaryType": "DISTRICT",
//                 "active": true
//             },
//             {
//                 "boundaryType": "LOCALITY",
//                 "parentBoundaryType": "ADMINISTRATIVEPOST",
//                 "active": true
//             },
//             {
//                 "boundaryType": "VILLAGE",
//                 "parentBoundaryType": "LOCALITY",
//                 "active": true
//             }
//         ],
//         "auditDetails": {
//             "createdBy": "0c884c94-a09e-4c24-8781-d33d358a2d38",
//             "lastModifiedBy": "0c884c94-a09e-4c24-8781-d33d358a2d38",
//             "createdTime": 1731304012550,
//             "lastModifiedTime": 1731304012550
//         },
//         "boundaryHierarchyJsonNode": null
//     }
// ];

// const preHierarchyData=[
//   {
//       "tenantId": "mz",
//       "hierarchyType": "MICROPLAN",
//       "boundary": [
//           {
//               "id": "7af7f64e-2d86-4a99-b3e6-800133950a04",
//               "code": "MICROPLAN_MO",
//               "boundaryType": "COUNTRY",
//               "children": [
//                   {
//                       "id": "c8d0c2ee-0b05-49b1-ae80-ec89e4ce417c",
//                       "code": "MICROPLAN_MO_16_FCT__ABUJA_STATE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "56077961-166b-4c7f-ac58-dc6941339dcf",
//                               "code": "MICROPLAN_MO_16_01_FCT__ABUJA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "142423a7-cd96-4327-b8cb-7fc05d02ab72",
//                                       "code": "MICROPLAN_MO_16_01_01_ABAJI",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "68c9b7d3-a237-4354-b2d0-f37f4829006e",
//                                               "code": "MICROPLAN_MO_16_01_01_02_AGYANA_PAN_DAGI",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "dbf3f1a5-1063-4c41-bd48-f21ae60e81f1",
//                                                       "code": "MICROPLAN_MO_16_01_01_02_02_ABAJI_GENERAL_HOSPITAL",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a76d4a94-1954-4d3f-b71f-ce8cf6966ed4",
//                                                       "code": "MICROPLAN_MO_16_01_01_02_01_M_C_H__ABAJI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "67829bc0-774c-4b8c-9f6e-4f841206e37d",
//                                               "code": "MICROPLAN_MO_16_01_01_01_ALUMAMAGI",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4293a7be-0a78-43e7-80ab-63f2030c1b2e",
//                                                       "code": "MICROPLAN_MO_16_01_01_01_02_ABAJI_TOWN_CLINIC",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5afb23fa-2f3f-43cf-92e6-fc45f05ecbac",
//                                                       "code": "MICROPLAN_MO_16_01_01_01_01_AGYANA_HEALTH_CLINIC",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "fe146896-c9a1-4f49-a609-5106c3355485",
//                       "code": "MICROPLAN_MO_15_KANO_STATE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "16e3305c-f37b-4908-beb9-1a55ca62473a",
//                               "code": "MICROPLAN_MO_15_01_KANO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "6980e969-38b1-4410-a185-a8081f636b2a",
//                                       "code": "MICROPLAN_MO_15_01_01_AJINGI",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "970a72ae-ec89-420f-a1a1-350fe513d8cc",
//                                               "code": "MICROPLAN_MO_15_01_01_02_AJINGI_L",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a74e9890-5cd4-4feb-b687-6e65fed0e6ab",
//                                                       "code": "MICROPLAN_MO_15_01_01_02_02_FULATAN_HP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "992a0625-bdae-4af9-8ed0-4dce6d439c76",
//                                                       "code": "MICROPLAN_MO_15_01_01_02_01_MARITA_HP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "78edc8b1-c88a-465d-92e3-b520ed627e3f",
//                                               "code": "MICROPLAN_MO_15_01_01_01_BALARE_L",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b1d50437-e5ba-46d5-8d8e-01d30029855c",
//                                                       "code": "MICROPLAN_MO_15_01_01_01_02_DUNDUN_HP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bba0977c-709f-4cf2-834c-8df9c3ed50ed",
//                                                       "code": "MICROPLAN_MO_15_01_01_01_01_MAIGANA_HP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "f95c83e2-803f-40b2-9542-2bf288f21ea3",
//                       "code": "MICROPLAN_MO_14_KEBBI_STATE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "084ed64b-fbfe-405e-8afd-df669fc3cef0",
//                               "code": "MICROPLAN_MO_14_01_KEBBI",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "9ecfb225-e191-4efc-bc17-b0fac0ca6ab4",
//                                       "code": "MICROPLAN_MO_14_01_01_BIRNIN_KEBBI",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "206d66d9-1d1c-4fac-b7a7-f107d47044cd",
//                                               "code": "MICROPLAN_MO_14_01_01_03_AMBURSA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f87d7cab-9de3-46f4-8a9b-824615729bda",
//                                                       "code": "MICROPLAN_MO_14_01_01_03_01_KE_AMBURSA_PRIMARY_HEALTH_CENTRE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "1a888605-0ec2-4b87-907e-279bef7766df",
//                                               "code": "MICROPLAN_MO_14_01_01_02_DANGALADIMA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "297cac24-9f7e-40f5-bd24-94b7a3749fd8",
//                                                       "code": "MICROPLAN_MO_14_01_01_02_02_KE_GAMAGIRA_HEALTH_POST",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f7092af9-7d5d-4c1f-afcf-f0731a757127",
//                                                       "code": "MICROPLAN_MO_14_01_01_02_01_KE_ILLELA_YARI_PRIMARY_HEALTH_CLINIC",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "63e19527-c31d-40f7-bd5b-103523b47130",
//                                               "code": "MICROPLAN_MO_14_01_01_01_GAWASU_DAMANA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "89c49ed5-33e3-4746-ae03-27c2eb506951",
//                                                       "code": "MICROPLAN_MO_14_01_01_01_01_KE_AKWARA_HEALTH_POST",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "6d49c8d6-1681-48b4-a747-d16a1a40333f",
//                       "code": "MICROPLAN_MO_13_GRAND_GEDEH",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "e8146ba4-6aa4-4cd4-8543-6fbb29d38578",
//                               "code": "MICROPLAN_MO_13_05_TCHIEN",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "0e0aa6aa-6a64-4a28-a6fa-be9c7b2690f9",
//                                       "code": "MICROPLAN_MO_13_05_04_TOFFOI_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "5e28afc8-8bb8-4c8b-a4f3-edd9057dfdf1",
//                                               "code": "MICROPLAN_MO_13_05_04_01_TOFFOI_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "818a17b5-3695-4440-a7c6-58abf36011db",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_11_GREBO_VILLAGE_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "32f1e455-c893-4bf2-917e-c8a8cd44a34d",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_10_GREBO_VILLAGE_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "57212a1c-9e6e-475f-8644-9fd6ff0137e9",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_09_CORRECTION_PALACE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c76ec623-9144-4e05-9120-b033006efe92",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_08_BAWAY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "98b0a356-775b-494b-a5a9-2f55dfff12ae",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_07_YOUBOR_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bfb16cb7-74f9-4c48-8f7b-671ac8adf493",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_06_KRAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8fa3ff67-0128-4976-97d9-7bb53ae197ca",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_05_MANYEAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a58022dd-d6d7-4e1d-943a-54bdffb3603f",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_04_BEEZON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "09ab77b8-3c38-41ac-a357-a59eb8a38489",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_03_TOFFOI_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "eb163eb8-6421-4127-9c21-184303099b6a",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_02_JELLU_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "06ed083e-e021-46dd-af1a-2668dd4c71f0",
//                                                       "code": "MICROPLAN_MO_13_05_04_01_01_GBEYOUBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "b9258f8c-e89d-4ef4-a069-d7815b546018",
//                                       "code": "MICROPLAN_MO_13_05_03_KANNEH_COMMUNITY_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "bef91160-909d-4b62-a204-2ca6f960a6d4",
//                                               "code": "MICROPLAN_MO_13_05_03_02_SAYUOH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b6c8d546-8a55-45f8-9974-0c4296cb6076",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_13_GHANA_GOLD_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e373a802-30b4-4ec6-9912-2055ddbbf991",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_12_BENTOR_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "91c3fe2c-0a3c-4dee-b6ed-aaa4730ec683",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_11_CHECKPOINT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3435407d-41fb-4727-8382-47b4bc1a9fbb",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_10_DORBOR_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "62995690-643e-4d40-8ff9-222bf1eec585",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_09_MISSIN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8a811a78-8c68-48ca-90d4-f3b2a62c8731",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_08_KALLAH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7b3a0cdd-62e5-4acd-994d-5a38ca335e8f",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_07_SAYUOH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cee12d56-fed8-4bc8-ac8c-83db95b38281",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_06_BANA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "23d5424d-1d88-4b7e-85c9-6d234ecb8dee",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_05_TAILEY_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d78b134e-1bf1-4bde-adc2-5677d635af3d",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_04_JEMECA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7cd956b0-1f81-4bfc-9eb9-4e7bf334d748",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_03_WULU_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b0f968cc-afda-498a-9ac8-3a11c0aaed16",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_02_GOLO_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a1e30ca6-33e9-46ed-acff-e5e0430556bd",
//                                                       "code": "MICROPLAN_MO_13_05_03_02_01_BENDLY_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "20acb95f-c729-402c-b1bb-6dbb49dfe4ee",
//                                               "code": "MICROPLAN_MO_13_05_03_01_KANNEH_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b6f21cf0-0394-403e-8214-7a35d393e6c6",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_19_P_T_P__CAMP_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8cc7a18e-3e17-4015-ab1f-dd0a17859bb5",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_18_PAPAYE_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2e46a8a4-6167-418f-9797-95ef3e5973e6",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_17_P_T_P__CAMP_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2dee1b9a-fa18-4e5c-b973-18bcf937f291",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_16_SAYUO_JUNCTION_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "88c83244-12ae-4d8b-b37e-85285a01d724",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_15_GEE_DWEH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3b87209e-c665-4238-8dd7-aae717f333c2",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_14_KPELLEH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f77ff649-eaa9-4d48-8a80-614be8281bec",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_13_DARK_FOREST_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fdf1ba17-ad0c-4517-9938-8814863f0fe0",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_12_PALMMAD_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba42b4a5-c71a-4598-8d9c-e5a754fe9bad",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_11_GBABO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5e6e943e-cd5a-44ac-8b2a-aaf9886c95a7",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_10_BODUO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4fe0f0e1-96f8-49a7-9740-1d430923542b",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_09_POWPOW_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c0c33a3d-f21b-4683-ae55-3eef2eeed6e2",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_08_PA_MOORE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d90647ef-65f5-4b06-9b0f-0d444de78b9d",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_07_DWEH_VILLAGE_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "53af0cf7-d4b7-4a45-a38f-eaaf861a06db",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_06_MORTOR_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "de144a47-2d34-48d3-b795-5e8b7c63d687",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_05_ERIC_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "83dab452-3a9a-4982-9b50-4e55adb2834c",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_04_DAKPENAL_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9de35b12-5631-4db5-b53c-2a142196603f",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_03_THOMAS_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "255967f5-12fd-4275-80a1-aa05cefc11fb",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_02_KANNEH_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d85b68dc-27d0-4e97-992d-2d7dc40798dd",
//                                                       "code": "MICROPLAN_MO_13_05_03_01_01_ANTHONY_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "19747def-b579-4123-9166-3ac513ab3c9b",
//                                       "code": "MICROPLAN_MO_13_05_02_GORBOWRAGBA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "03cafa7f-697b-4dd4-8bea-5c9dcd265ae2",
//                                               "code": "MICROPLAN_MO_13_05_02_02_KUMAH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e79edc0f-75e5-4d08-bcc6-cc4cf08f357d",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_13_VICTORIAL_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e4618587-6ecc-443d-aeed-c44df8e65d58",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_12_JELLUE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ffa6885f-4de7-4be2-8a12-e1ced9a2e039",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_11_ALPHONSO_GAYE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0dc7af87-a122-449a-8c57-f26d22839159",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_10_BASSA_VILLAGE_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "12178017-176d-45e5-9bcd-b618d1dba99f",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_09_PENNUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f21b1a19-df15-4bc3-9932-889b4d299065",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_08_KUMAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ace46773-4e50-46d0-af62-5685e5c333a9",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_07_ZAYBAY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "20cf0c1c-9a7e-438d-be78-a9f69f509013",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_06_JAIBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7d0b4d00-acf3-4bd3-a85f-06ca1d80e80f",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_05_GBARBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "eb633839-3841-4d43-9c7d-27926169182d",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_04_TETE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6d9ef1a4-2b71-4fa9-ae43-85c289dea70a",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_03_PELLEZON",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cf230b76-7d4b-4ada-9cdc-2db20eb0d443",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_02_JARBAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aebf1404-25c4-43c3-8fe8-f33872e412e3",
//                                                       "code": "MICROPLAN_MO_13_05_02_02_01_TCHIEN_POLAR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "07dc644f-1f9b-42b4-9558-97754ef39bb6",
//                                               "code": "MICROPLAN_MO_13_05_02_01_GORBOWRAGBA_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c9781398-2a16-46d1-9d3e-aff9c671612f",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_16_AMARA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9c22fa96-7ba6-453d-a408-b152dca1d760",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_15_GREAT_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9779020a-2ae4-4e1e-ac4e-aa852e9aa512",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_14_JARDEIAH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e8404dd4-3cef-474c-a191-609260c7e0b7",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_13_ZINC_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f94eb81f-d43f-48ee-95f0-c7d3715bfc50",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_12_YOLNY_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "70df360e-9a71-4d7d-b126-456e0107dbc4",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_11_LIFE_CAN_CHANGE_GOLD_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4c89702b-5782-4569-b025-de06b7e080a3",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_10_KARDAFFII_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7109add6-d32a-4f73-b49a-35689e1e6b1e",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_09_JAMES_GAYWAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aa450611-22d5-4383-a9ef-0870a2710d28",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_08_JACOB_GAYE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5cc8c023-c3aa-4ee8-b05a-0cf13475f0c6",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_07_CAVALLAH_CAMP_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "267cffbd-c490-443f-bdb0-ec08bfc7b22e",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_06_CAVALLAH_CAMP_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ad93e293-7b1e-41ea-bf0a-a55cbaea8631",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_05_GBORLUE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9c6c4e1c-db6a-4c5c-ac29-bb27e8926c1e",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_04_SLOMEN_CAMP_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "06f9c23d-03ed-4181-afb1-ce48462c48a7",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_03_SLOMEN_CAMP_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef444844-ca2f-4359-96ad-16f14b7fb473",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_02_KYNE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "87325e3b-9e83-43a3-82e5-343590023e08",
//                                                       "code": "MICROPLAN_MO_13_05_02_01_01_GORBOWRAGBA_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "92bfb6be-2d06-4490-ab78-7792364d4650",
//                                       "code": "MICROPLAN_MO_13_05_01_MARTHA_TUBMAN_MEMORIAL_HOSPITAL",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "8907eed2-0a52-407b-9fdc-96c1820f530b",
//                                               "code": "MICROPLAN_MO_13_05_01_04_ZMHS_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8315ce9f-3e73-4c48-a003-a0c7860f4d2b",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_18_CATHOLIC_COMPOUND",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "19d8cd4b-660a-40f6-8011-705a9d14da40",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_17_GUNNIE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e1a8a57a-7656-414d-a994-c0c59e558c89",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_16_BLUE_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "33010ff7-e7cd-4297-bdb5-673bba41efe5",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_15_AIR_FIELD_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b61ff17a-b7bb-47be-b767-8bde01385829",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_14_NEW_ZWEDRU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "179f8c54-9214-4a26-bd99-ac721344893d",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_13_DISCO_HILL",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a30e7352-8b9f-44c4-b856-16782509bf5e",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_12_BOLYVILLE_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d62bf659-ab10-4b30-b8fd-8776bcef8f94",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_11_SINOE_ROAD_MARKET_COMM_",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "26f17052-8b54-4bec-bbdb-b2a0f3e26fe3",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_10_PINEAPPLE_VILLAGE_ROAD",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3f08185f-2f24-4640-b894-97008940a8ef",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_09_CARR_CENTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "04078bb1-7ad0-4277-a50b-7efd7e0e1172",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_08_AGRICULTURE_COMMUINTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "afe844f3-74d6-4dcb-b03c-4ebb7f5d0c44",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_07_MAP_OFFICE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aafd9c34-074e-41e6-b380-ab870e3b3fc5",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_06_EDUCATION_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5e74d115-5c66-472b-a34c-ed6dfe781d4b",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_05_WORD_SOWER_COMMUINTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1ecb44b8-2e1b-4f72-abfa-e9bfe6e8dbca",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_04_BOLEYVILLE_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cce0bdb2-0fcb-4ba4-a6fd-e1e5b00adec0",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_03_BROWN_SAYEE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "08667ac0-5a34-454a-a3c9-454b82e54083",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_02_PEACE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "662c2134-8f43-4e4c-8f85-8a27d560e0e2",
//                                                       "code": "MICROPLAN_MO_13_05_01_04_01_ZMHS_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "d4186421-cd8c-4cb3-b9ae-22fe8304046a",
//                                               "code": "MICROPLAN_MO_13_05_01_03_TODDY_VILLE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f1cf2bd0-b59e-45ad-a017-fa1ba8f7e665",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_12_JENSON_VILLE_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "193d5829-fca5-4f02-8234-bc797be39959",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_11_DOUYEE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9893a937-7d52-4a8d-80fd-f151af2a4cd8",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_10_CANTOMENT_SITE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49add153-448c-4754-9a43-dd10d2aa2982",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_09_BLESSING_HILL_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "292a82fa-a458-4ab3-9557-77fe65a0cb04",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_08_JENSON_VILLE_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "27fe4216-e41e-4a66-8f62-144b1d206674",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_07_TODDY_VILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "941c3e09-2ffe-4011-b13f-444a9bedb2ce",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_06_PENNUE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e36fd878-2e39-4f5b-8015-dfd3a57bd9c2",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_05_KRAHVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a42400d3-a11a-426c-ac29-0b952767444e",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_04_GORBO_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c6494210-4f2e-4fb3-b2ef-a2a476d77b7c",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_03_FDA_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8896cc10-bcc7-4553-8c8c-79bec6993133",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_02_CHEAYEEVILLEDOUYE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "387889d4-d148-4c3d-9f60-1dd1321b3eb6",
//                                                       "code": "MICROPLAN_MO_13_05_01_03_01_BARLAVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "7b91349c-c9ca-4de8-86b5-1f2a0a745a8f",
//                                               "code": "MICROPLAN_MO_13_05_01_02_TRIANGLE_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "bc1cb6e8-5b28-428b-a9c8-658688a04ab8",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_12_GARLOVILLE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aa6e5dc7-dbef-4199-a160-712e7e51b1c3",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_11_SUAH_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e9da2c88-a07b-4f61-b3ef-d4212a56d6f1",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_10_KANNAH_ROAD_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7e32572c-403d-4c2b-bb1e-0c64ccf1dfc8",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_09_ZWEDRU_CENTRAL_MARKET",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "034ff69a-0b35-45b6-995a-90605a8ca712",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_08_ZOE_BUSH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b7e5c72a-faeb-4df8-95f3-931d1df7701e",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_07_CITY_HALL_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef987f2a-0485-474a-80ac-433857bb4456",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_06_WELBO_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "62bd91ae-a50f-43a4-a1a0-f5ee4b1c5997",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_05_TRIANGLE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "381581bd-8d77-4847-9d05-5224891b3c3c",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_04_SPS_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2fea6efd-29e2-436c-98ad-40424b49b533",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_03_BAPTIST_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1d9328b1-0284-4750-8c53-192f9f7dbfff",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_02_TOWAH_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b0191e85-54b7-4828-baf6-1915f30d4281",
//                                                       "code": "MICROPLAN_MO_13_05_01_02_01_A_G__COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "972fc336-1897-490c-bd23-86b34bb6257c",
//                                               "code": "MICROPLAN_MO_13_05_01_01_NAO_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b38c53f6-a3bd-40ff-b7f5-1c3e4da8c08c",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_09_NAO_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8feb1588-0007-4ccf-b0c9-a10dc4da9d53",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_08_KPASUAH_HILL",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c144f39b-0d73-40b5-a861-34a6ad1a4042",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_07_GBAGBAVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1f58bf21-aca4-48cf-88b0-fb3ea65d448b",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_06_ELRZ_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f25938ce-022b-4b57-8dc0-c1485820b191",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_05_MANDINGO_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7759fc30-7001-4250-94f0-784584972cbd",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_04_ZANBO_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "022300c8-4c4d-475c-91b4-b5918a1ffa8d",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_03_KYNE_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2f87eeb3-3eb7-4181-9045-83cc64293dde",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_02_GBOE_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "edac8a5d-6db2-414f-b4c7-03ecd6e337ca",
//                                                       "code": "MICROPLAN_MO_13_05_01_01_01_BOWEN_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "c3b8bb30-becc-451a-aea6-9cf57152ad57",
//                               "code": "MICROPLAN_MO_13_04_PUTU",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "5a3abe7b-ad50-48e7-abc1-81494b117cff",
//                                       "code": "MICROPLAN_MO_13_04_02_PENNOKON",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "35fae242-6ff3-422e-ac80-76bc8f7b6815",
//                                               "code": "MICROPLAN_MO_13_04_02_02_KARLOWLEH",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "13b27296-2e13-4a3b-91f1-50d51a86bad8",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_07_DOUBLE_BRIDGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e30e86df-da69-4f6d-b472-f67dc09f1719",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_06_POLO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3ca8bb9a-8582-487d-8e4d-a20a3d27566d",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_05_JARWLEH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4a770eda-0b89-401b-95e2-01fbcf8f520f",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_04_WREGBALEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f23318bb-5226-4d27-a482-f0aa22760b39",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_03_JOHN_DAVIS_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "29803175-014c-4070-ac22-6e692a0cd6f2",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_02_DUO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "48c23f3b-55ef-4557-a5d7-27172a9763e6",
//                                                       "code": "MICROPLAN_MO_13_04_02_02_01_KARLOWLEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "c58e6fc5-bb84-44db-bfc6-8cb56b55efc6",
//                                               "code": "MICROPLAN_MO_13_04_02_01_PENNOKON_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7401d6df-fe28-4503-bc75-b629d8ab5866",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_07_FARLEY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "97bcfc66-9379-4e6a-a7ec-a79969730428",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_06_GBEJOLOBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "289e7849-dcd4-473d-ace2-e5f22601217c",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_05_BOLEY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "84139b09-3d0f-4a98-95c9-2ff581fa6a00",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_04_PETROKON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fb777f4f-65e2-4d7f-b8e9-967bb4a8040e",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_03_PANWLOH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a0141fe2-0007-4be7-9129-1f4f2064bf39",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_02_GEEBLO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "325e3114-969d-4c04-9339-32450e2507bc",
//                                                       "code": "MICROPLAN_MO_13_04_02_01_01_PENNOKON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f4a1ae68-fbc9-4f98-a92b-3f9cbcc83208",
//                                       "code": "MICROPLAN_MO_13_04_01_JARWODEE_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b20ea8e8-b380-46bc-99b6-8469a3b361e2",
//                                               "code": "MICROPLAN_MO_13_04_01_02_WHITEMAN_CAMP",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a0ee896a-8786-4641-b223-ac199b111f3f",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_11_SLAGBALEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e78322d5-958e-4360-bb5c-0afe260d73ca",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_10_GBARYEA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "41bc0f89-cb06-4797-8b37-b68d0df008b2",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_09_CEMENCO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1bb1a014-adbf-48f5-ac2a-fc3ce3c18237",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_08_ABLEE_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3a247a97-708a-4e28-8807-b4f1b7d56b25",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_07_WATER_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7de077b7-4a24-43bf-b816-d123089781ef",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_06_TUGBA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0b2eeaf2-8d9e-4c06-baad-a0f35070710e",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_05_JARGBAH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a9b099de-1a38-4a97-a25c-7d8ed6bb96f4",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_04_SAYLEE_PYNE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba7312ef-0a43-47cd-b7dc-adc1d22ec168",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_03_WHITEMAN_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7883e684-ff5a-457a-97ea-6f52152ea466",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_02_DOWN_DOUUGBE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fba18be1-26dd-4972-843e-6dfc195cd913",
//                                                       "code": "MICROPLAN_MO_13_04_01_02_01_CENTRAL_DOUGBE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "35db1897-0e6f-4cc4-9c12-c10975c26833",
//                                               "code": "MICROPLAN_MO_13_04_01_01_JARWODEE_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6ef2c5fe-f811-4a00-a05c-72cf7717f139",
//                                                       "code": "MICROPLAN_MO_13_04_01_01_06_ZONDEH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "38184b65-02dd-4b17-8c23-7f047eddece1",
//                                                       "code": "MICROPLAN_MO_13_04_01_01_05_TWEH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9ce3fb07-2d80-403d-adb1-94bb0716acc5",
//                                                       "code": "MICROPLAN_MO_13_04_01_01_04_NEW_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0a27f0e1-52d8-447c-a8de-1421d6d97f6f",
//                                                       "code": "MICROPLAN_MO_13_04_01_01_03_SEOH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "80a47c90-168b-4dff-b107-7ead4019785c",
//                                                       "code": "MICROPLAN_MO_13_04_01_01_02_KEHTOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "24d374ce-ddbd-4a0b-8beb-b85c133e2a5d",
//                                                       "code": "MICROPLAN_MO_13_04_01_01_01_JARWODEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "10895f14-f587-4c8c-a28a-1e1bcd258115",
//                               "code": "MICROPLAN_MO_13_03_KONOBO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "7c3b07c4-519c-4b4a-9328-9fdafa0b0c66",
//                                       "code": "MICROPLAN_MO_13_03_02_BOUNDARY_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "851ee417-18d5-43e9-b2e7-cfd046c0b470",
//                                               "code": "MICROPLAN_MO_13_03_02_03_WULU_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ea27df8d-4711-470a-9b75-bab03183cdf1",
//                                                       "code": "MICROPLAN_MO_13_03_02_03_03_VARGLOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d39b04b4-2f13-4f8b-9f55-64877de401c9",
//                                                       "code": "MICROPLAN_MO_13_03_02_03_02_TUGLOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4221e474-fbd7-45a2-b967-2cec3262ca59",
//                                                       "code": "MICROPLAN_MO_13_03_02_03_01_WULU_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "a19610f4-3119-4ec1-80fb-cc470ed92462",
//                                               "code": "MICROPLAN_MO_13_03_02_02_KOTOMIE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "eb7e83e8-d135-4551-8b05-084ce6778b36",
//                                                       "code": "MICROPLAN_MO_13_03_02_02_03_KONOBO_SAYUO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fe96810a-a75d-4ac8-b77e-7185a12afc22",
//                                                       "code": "MICROPLAN_MO_13_03_02_02_02_CHEA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1b8a898f-bb41-4357-af1a-18d0141ae769",
//                                                       "code": "MICROPLAN_MO_13_03_02_02_01_KOTOMIE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "46fd117a-0108-4eb1-87e6-e34358db46d9",
//                                               "code": "MICROPLAN_MO_13_03_02_01_BOUNDARY_2",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b3efe220-c54d-4548-9a36-7eca4b071520",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_11_DELAYEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2f6f268f-a989-46b9-9ca8-9cf699ed2664",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_10_BROWN_VALLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e792b593-9d93-44c6-809d-df8317497bfc",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_09_PETER_VALLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "794f9ce8-f115-426e-9e62-e82be5dc510d",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_08_YENNEH_VALLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "83253e47-7497-451b-9a5e-eed097c7658b",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_07_TORH_VALLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "525445d2-6ebf-41f6-9fb9-7ba530f75699",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_06_DWEH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ea7804b9-2b7d-47ef-b03c-a7a08f5e4b45",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_05_GARYEKOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "84af32f9-b6e3-41b4-be86-835a6244e682",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_04_YALLAH_VALLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "30354e4f-aa8c-4019-ba14-c687abdf9780",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_03_SINNTRODRU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ae189bea-ccf0-46e6-9625-7a313f6d60ee",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_02_BOUNDARY_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "91046008-6d59-4987-a18c-b69bea9e8f62",
//                                                       "code": "MICROPLAN_MO_13_03_02_01_01_BOUNDARY__2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "cf57d727-f7ef-4f89-a0ea-a75c3e0085dd",
//                                       "code": "MICROPLAN_MO_13_03_01_KONOBO_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a5b6629c-5414-4882-8e66-5f090b346470",
//                                               "code": "MICROPLAN_MO_13_03_01_10_AMERICA_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "130e4f19-142b-403a-8598-214215be078f",
//                                                       "code": "MICROPLAN_MO_13_03_01_10_04_TWABO_DEHJELLAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "699c95d1-1cb9-4f62-ae4d-42c95ed0d409",
//                                                       "code": "MICROPLAN_MO_13_03_01_10_03_NYONGBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8ccec8f2-95e6-48eb-94c8-f9be3f26cc84",
//                                                       "code": "MICROPLAN_MO_13_03_01_10_02_JAMICA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c7c84fa7-a148-4553-8a17-01e2fab3903c",
//                                                       "code": "MICROPLAN_MO_13_03_01_10_01_AMERICA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "fe1c989b-56ce-455f-a8cd-647380662c40",
//                                               "code": "MICROPLAN_MO_13_03_01_09_BARLIKEN_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8a9bea97-c175-498f-9936-86a19b94dbfd",
//                                                       "code": "MICROPLAN_MO_13_03_01_09_01_BARLIKEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "f5e6730c-b65e-43d7-af14-df2218d6c23b",
//                                               "code": "MICROPLAN_MO_13_03_01_08_HEADQUARTER_CVI__COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b247c095-f3be-4026-b9d1-6ebbc182ce79",
//                                                       "code": "MICROPLAN_MO_13_03_01_08_03_BELLAYELLAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7cc20f78-b0e6-46c7-bec0-ec2cf096b622",
//                                                       "code": "MICROPLAN_MO_13_03_01_08_02_BOLO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6b6ef9e1-a168-46b1-9d66-99a9e5102e5b",
//                                                       "code": "MICROPLAN_MO_13_03_01_08_01_HEADQUARTER__CIV__COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "51734e97-3ac2-4e65-aa54-9676554513b1",
//                                               "code": "MICROPLAN_MO_13_03_01_07_NEW_CREEK_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7fc55c04-41a7-4fc5-adfd-b7acccda8d8b",
//                                                       "code": "MICROPLAN_MO_13_03_01_07_03_TURNING_POINT_CVI_",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cdc5f036-829a-4d64-a082-6096aac7b979",
//                                                       "code": "MICROPLAN_MO_13_03_01_07_02_SOLO_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8ffccfc9-31ba-4707-95df-4170123d649d",
//                                                       "code": "MICROPLAN_MO_13_03_01_07_01_NEW_CREEK_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "3668fa85-8e87-4de2-b76b-a94a3c7699ab",
//                                               "code": "MICROPLAN_MO_13_03_01_06_KOA_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ab09671a-8fb0-4e4d-bac5-9a065d5169cf",
//                                                       "code": "MICROPLAN_MO_13_03_01_06_05_ZD_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd957686-f308-4272-af91-e830f2ad704b",
//                                                       "code": "MICROPLAN_MO_13_03_01_06_04_PA_MOORE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e8fe2548-2290-43d7-9645-d0ec4b3766ef",
//                                                       "code": "MICROPLAN_MO_13_03_01_06_03_GLAY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d4f4135b-145b-497a-90b4-798f5d89eddf",
//                                                       "code": "MICROPLAN_MO_13_03_01_06_02_ZARR_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc840661-d14f-4947-9df8-45fcc647af92",
//                                                       "code": "MICROPLAN_MO_13_03_01_06_01_KOA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "30e9bec7-f6cc-4e91-a24a-bf37bd6a6846",
//                                               "code": "MICROPLAN_MO_13_03_01_05_TARLOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "63056b15-83c1-4783-9669-b91a8f0ff4e4",
//                                                       "code": "MICROPLAN_MO_13_03_01_05_06_TEMPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd62fcb6-ce2c-4855-b5b2-8f6d9dbdafb8",
//                                                       "code": "MICROPLAN_MO_13_03_01_05_05_GARLEO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2e31b920-2d63-4106-b96b-5568620c0298",
//                                                       "code": "MICROPLAN_MO_13_03_01_05_04_YEOH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "509acac9-1453-4290-b521-e9d38c584f1a",
//                                                       "code": "MICROPLAN_MO_13_03_01_05_03_CLOTELEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "306eac10-ab24-49fd-95a7-40d5856771a2",
//                                                       "code": "MICROPLAN_MO_13_03_01_05_02_BAO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2b324076-ae41-42a8-b5d5-1c2ef6965ecc",
//                                                       "code": "MICROPLAN_MO_13_03_01_05_01_TARLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "3eaba731-d8bb-4bb7-b424-90b38bacc8fc",
//                                               "code": "MICROPLAN_MO_13_03_01_04_BILLIBO_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a2609a6b-bd56-4cf9-893d-08c628427f52",
//                                                       "code": "MICROPLAN_MO_13_03_01_04_03_TWABO_SAYUO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "67a356ee-01ae-44b4-87f9-dd3eb6080e5a",
//                                                       "code": "MICROPLAN_MO_13_03_01_04_02_TWABO_MISSION",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6be15d3a-c541-4c7e-9c96-879904625a0d",
//                                                       "code": "MICROPLAN_MO_13_03_01_04_01_BILLIBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "ea664f98-bfad-414b-8d2d-c346b041c1a5",
//                                               "code": "MICROPLAN_MO_13_03_01_03_BARWU_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "13f37fad-a7c4-4cf7-a25b-d0864a97746c",
//                                                       "code": "MICROPLAN_MO_13_03_01_03_06_FLAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fcdd6225-dfcc-4dae-934d-5a2043bfe0d8",
//                                                       "code": "MICROPLAN_MO_13_03_01_03_05_GBARWU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6eceb5fe-aa1f-4fd6-977a-c43590af631d",
//                                                       "code": "MICROPLAN_MO_13_03_01_03_04_DRUWAR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5ffbe8d8-0f0d-4321-8b3f-a0a07ddd4a46",
//                                                       "code": "MICROPLAN_MO_13_03_01_03_03_PEAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ea336092-77b8-4af7-856e-43f2f0f7d1db",
//                                                       "code": "MICROPLAN_MO_13_03_01_03_02_GARGLOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "57c56be9-84b2-4b63-a78f-d51cd0ca107f",
//                                                       "code": "MICROPLAN_MO_13_03_01_03_01_BARWU_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "36dd8841-8382-44e6-8717-3d019dd23592",
//                                               "code": "MICROPLAN_MO_13_03_01_02_DWEH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7fb29b97-7144-490a-877f-d65252bc269d",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_11_GLAYGEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5ab8700d-5da3-44fa-89c2-90b238e4e353",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_10_BUWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6a474fd0-2b81-4f7b-aa8e-c4132eaab83e",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_09_WHYBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b6185dcc-8abc-4b73-8eb1-189d7ce04948",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_08_DELAYEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fbe3b88b-a139-4aeb-8bce-62626a5153a1",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_07_DROUGLOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cd485955-d24c-4588-8908-2d06e49a6032",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_06_DEHJALLAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5dea547a-2b18-4e1d-89e6-1044adfc4181",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_05_WLABO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4342f3bb-deff-4e84-9061-d37f26db3b36",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_04_BANGLOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6241bd2b-ba01-44a0-8a3c-fad217b7a506",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_03_DOWAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8c298311-2dd8-4637-b79e-7b087de1b83c",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_02_QUAYE_VILLAGE_ABUJAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5b4d0191-0629-40e5-8a0a-63d0a65f4667",
//                                                       "code": "MICROPLAN_MO_13_03_01_02_01_DWEH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "c4154783-c1f0-4b52-a09a-eeca52093644",
//                                               "code": "MICROPLAN_MO_13_03_01_01_ZIAH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "161e049e-2e5f-415c-a8b1-f6238665af26",
//                                                       "code": "MICROPLAN_MO_13_03_01_01_01_ZIAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "055b2442-3c75-4b40-bf9e-ec0a316455ba",
//                               "code": "MICROPLAN_MO_13_02_GBAO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "57e26af5-77be-47d6-a35e-de9f822ca8bc",
//                                       "code": "MICROPLAN_MO_13_02_03_GBOE_GEEWON_COMMUNITY_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "9fc72c99-2689-404a-9694-e082e4181aac",
//                                               "code": "MICROPLAN_MO_13_02_03_02_DARLUE_VILLAGE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "46d2b00d-a85e-4ec7-b469-00659e170593",
//                                                       "code": "MICROPLAN_MO_13_02_03_02_01_DARLUE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "2545c28e-6dc2-4fd4-bf83-457811463edf",
//                                               "code": "MICROPLAN_MO_13_02_03_01_GBOE_GEEWON",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c2c734e0-1a85-4e38-bf5c-43bca11793bc",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_12_ABENEGO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e1261433-849a-45f9-ae34-d74ae128624e",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_11_LAWRENCE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6d6db92b-0929-4637-9299-e856edfdcda9",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_10_GBARWU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "92e0d7b7-7c0b-4dc9-bc50-70466cf8f33c",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_09_JERRY_TIAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0cf75f79-f104-4cad-a9dd-8bd603b87c49",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_08_PANNEWEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dcb5ba9b-594e-4083-954f-ea3a516f90ca",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_07_ZARZAR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1228eae6-df25-4b9e-9960-2ea903e724eb",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_06_MADRA_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e9119e88-c2f4-4244-a383-15f848a4edd4",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_05_ZAMMIE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f1a882f5-8989-4714-82b6-39a91e5edcbb",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_04_CHAYEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "66f0a6bb-b92d-4902-83f1-46296e02b801",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_03_ZEAGBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4418597e-3cd0-4b28-bf8f-a0ca682306d6",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_02_ZEAN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "38752863-5769-4ed3-8da1-711d0ac7936b",
//                                                       "code": "MICROPLAN_MO_13_02_03_01_01_GBOE_GEEWON",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "0e22467c-8129-4706-9592-735a2fa9b011",
//                                       "code": "MICROPLAN_MO_13_02_02_POLAR_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "ee61de6f-8ac3-4f1d-a12b-b065cc5bf053",
//                                               "code": "MICROPLAN_MO_13_02_02_01_GBARZON_POLAR",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c3dd86da-b632-4e64-b46c-da3fe4a071d9",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_07_ZALAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49ec9855-8f40-4c87-8d5f-d021e9e1f9c8",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_06_SOWOE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3cc52198-4d4a-4631-acfb-8d1159623a07",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_05_JALAYOU_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ee666d82-d9ff-468b-879c-fe76f632c43c",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_04_KULEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7918594e-8af9-4356-a027-5e3ac8765ad6",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_03_ZUAJAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "88437875-1245-4244-a72c-6d04db5b3c5d",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_02_CHELSLA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ddea9187-2282-4d3f-80db-9074f2a7adbd",
//                                                       "code": "MICROPLAN_MO_13_02_02_01_01_GBARZON_POLAR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "5b447729-d0be-4e75-8d9e-aee211c4840f",
//                                       "code": "MICROPLAN_MO_13_02_01_GBARZON_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "4ae72d4f-3f18-44b4-96d5-6bc52f8f4617",
//                                               "code": "MICROPLAN_MO_13_02_01_03_GBARZON_JARWODEE_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "2dc3c5c2-29b7-4e72-ae4b-1de8f1eb0d99",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_10_CHINESE_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef7aeec8-d699-4d64-b397-1094e3e9a2fe",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_09_KANYEA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c0fc341e-4e7e-4e33-8c5e-5388b114a5cd",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_08_BARKOR_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ce61e586-db08-4648-a5f9-534b68ad7a79",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_07_GBARZON_JARWODEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "66bb9e0c-6010-41ea-9a42-45e9db4067ba",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_06_JULUZON",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1b9cb6e0-57a6-4e88-8104-200080cf7071",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_05_KWEOH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4da8331b-d5b9-43b9-8af8-b18d7bbcb0d1",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_04_DAYBLEY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "623ba1ce-e6ca-4289-9c23-27b5285fba4d",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_03_TELEDEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2bd5d8e0-89b9-4615-b005-c21b316f26d1",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_02_GBARKEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "86bb8bea-b2e0-42ae-888e-6f7725f0aa29",
//                                                       "code": "MICROPLAN_MO_13_02_01_03_01_MOMBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "333aa9da-2c40-4431-a516-80f8ca580cb9",
//                                               "code": "MICROPLAN_MO_13_02_01_02_GBARZON_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "d234e669-63f1-4896-9260-985ad4b7b59a",
//                                                       "code": "MICROPLAN_MO_13_02_01_02_04_SAYON_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "66935ae3-5381-4db0-a1e2-7f4f2abb9d30",
//                                                       "code": "MICROPLAN_MO_13_02_01_02_03_KONUWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f0300714-a02c-4336-9e49-9ad555a800e9",
//                                                       "code": "MICROPLAN_MO_13_02_01_02_02_GOR_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ca09559c-fade-4421-a80d-dc3641d51b71",
//                                                       "code": "MICROPLAN_MO_13_02_01_02_01_GBARZON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "5336c1d3-b0ae-49c2-b32c-a47ffea27aed",
//                                               "code": "MICROPLAN_MO_13_02_01_01_ZLEH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9480fe20-8d98-4d1a-b025-8a03b21f6fec",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_07_PARBOE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "940fa1c8-439e-4001-9a85-dc714c4007c2",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_06_WULOTONDEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8f5a7c2e-70ca-4834-a13d-f0537a38e67c",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_05_POUH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ac5bf76e-6d3f-431f-ae3b-7a82e7824e70",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_04_TOWAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "60fe34e3-a861-4e00-bbc4-54a96971b7e7",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_03_GAYE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b1bb97ac-e8b9-43ce-ad75-031ff2819214",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_02_GBAYEA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ed83487e-6ff6-4064-abe0-a36f65323206",
//                                                       "code": "MICROPLAN_MO_13_02_01_01_01_ZLEH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "fc9b95fe-8460-4cc2-842c-c7c0f3cbbf68",
//                               "code": "MICROPLAN_MO_13_01_CAVALLA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "503398b8-8084-4e2f-a1e7-9b6f9017b7ff",
//                                       "code": "MICROPLAN_MO_13_01_06_GBOLEKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "49dd43f9-d2ff-4593-a71a-f3bd143bf902",
//                                               "code": "MICROPLAN_MO_13_01_06_01_GBOLEKEN_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a7a85180-16fb-4ef1-856d-ded0628a1a04",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_15_SOLO_TOWN_INSIDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "70b82b74-99f6-46b4-9923-3889d5609ff8",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_14_DOLEZON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cca36d77-b748-4841-94f4-75745523bb8c",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_13_FRANZAY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5c4cfac8-f9e9-436a-94b7-0cb1d8a2970f",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_12_GWENEBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e57704b5-4634-4324-9805-1cd8cab965aa",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_11_ZONE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4e4fd842-1e1b-4e19-a38d-4ace4bc33dde",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_10_DEH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d26bf60e-2a4e-4929-8eff-9a28c3c14537",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_09_WILSON_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "be8c77bd-4394-47cc-a6a2-15270c113eeb",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_08_JONE_ZBAYEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4c4f8980-4e44-4a43-a3ab-e24271072321",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_07_ZIWAY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c9dba232-cef2-4e61-8cfc-394cee6e95da",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_06_SEWIEN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "92efcd8b-8e42-4de5-8b6c-9780374e6749",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_05_SEWIEN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f5c4abe6-6026-4967-82f5-2008a6ac6220",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_04_DWEH_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b7fbeb67-c668-48a0-a629-3869d4a5e63c",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_03_GAMBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "656d8103-2a47-4682-b1ab-163adaef9387",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_02_GARLEY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0ca85da4-e789-4d09-ae53-c3b12c881a97",
//                                                       "code": "MICROPLAN_MO_13_01_06_01_01_GBOLEKEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "26007c87-d302-4045-a13e-83542350c41d",
//                                       "code": "MICROPLAN_MO_13_01_05_ZAI_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d22593ad-f105-42cf-83ed-2ff90320ee81",
//                                               "code": "MICROPLAN_MO_13_01_05_01_ZAI_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "22967859-1e5a-4f12-9bc9-d4411e5bffe2",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_14_PERER_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5ebb8c30-4357-4ff8-bf5f-09f5cd9f4b70",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_13_KANGBEKEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dcb38792-59ad-42e9-ab72-33ef72c5b1d8",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_12_ESTHER_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49a14fb8-4b88-4a77-997d-23c1d6abbcbb",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_11_TARLUE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9faf75fe-851c-4d7e-a814-6c72644de8a9",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_10_FLAHN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7cb92886-af5e-47f1-aada-97e5370933d4",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_09_QUIAH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8d5bb8c5-01a1-4730-b769-4c6a1bd7fb0c",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_08_KOHU_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "52b4cc35-800e-476d-97b0-e007d5ab15d5",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_07_ONE_MAN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2a7ec8c5-fadf-4a88-bc2c-09f793d25157",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_06_KOON_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dfa9299b-11ca-4e22-aaaf-52d692edf993",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_05_SOWAKEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dfd8da92-fb86-45d6-acb6-21e1dcdd4e01",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_04_BASSA_VILLAGE_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "86cb3107-a1d7-4952-b59b-ab00cd52965d",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_03_GWEIN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef3d062d-f510-437a-9d3c-9e3f1ff3e56e",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_02_BARTEHJAM",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7cde8d6f-5271-455e-88a9-b7b452b74024",
//                                                       "code": "MICROPLAN_MO_13_01_05_01_01_ZAI_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "ca6329a5-073f-4f65-adbc-3554d01ba27b",
//                                       "code": "MICROPLAN_MO_13_01_04_TUZON_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "bc0ad004-50e5-4853-aed7-e65c1fbccea2",
//                                               "code": "MICROPLAN_MO_13_01_04_01_TUZON_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8a7c62a6-0b8e-41b4-aa01-c74d6c882b02",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_09_DOEBLEE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "043b0e50-15c9-45dc-830d-345221062a81",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_08_BIG_JOE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "14285239-3b6f-4590-a9d3-4d07eeb6c24a",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_07_GOLYEAZON_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "88c2be68-248c-4bf4-8b6e-57f06e8ec5e6",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_06_JALOKEN_VLLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49200d53-ac87-4a14-98ef-25fd45f2bbd2",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_05_CHEALUBLEE2_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4593a136-b50f-44f6-a463-ad679426f889",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_04_CHEALUBLEE1_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "417cb24c-35ce-4d18-a417-cbc0e08cf581",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_03_KAHN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f94aa195-5a8d-460c-90e4-c1248f7a37ac",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_02_SOLO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "37148f41-9186-4423-b682-bb3b94423826",
//                                                       "code": "MICROPLAN_MO_13_01_04_01_01_TUZON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "36b4f846-12f1-4505-86cb-24b641f616e3",
//                                       "code": "MICROPLAN_MO_13_01_03_JANZON_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "0abb7da8-e6a0-4352-80eb-126982a09d67",
//                                               "code": "MICROPLAN_MO_13_01_03_01_JANZON_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0cb40bbf-e206-479c-80d2-6f972bb7b925",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_14_GOANWONKPI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d1cc561c-c01c-4f53-aaae-b170a414d690",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_13_KAHN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5f45598d-df35-4324-b126-fc2859745780",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_12_SOLO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c49da979-8085-4604-b04e-9c6a27564f40",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_11_DUBA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc07e967-0447-48c3-bd64-2e004cb1f024",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_10_GLAHN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "efe9e3bb-29fb-4ca5-ae9d-58be0687a095",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_09_BANGBOR_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5edc0c8d-28b0-4fdf-9ce8-909fcd54b977",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_08_BOE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2e7a7214-d959-4e41-bf0e-8e0b7e878bdd",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_07_OLD_POHAN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "72d5c353-88ed-4cc6-ab46-003382705df6",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_06_NEW_POHAN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3cc2f2da-772b-469b-a534-7b2511b8c95f",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_05_BAYWAYDEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "44a89920-e1d4-4742-985b-04ea375a2b47",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_04_JANZON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "999b545a-3ea5-4db5-ad5e-ff80a2ac69ab",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_03_BANANA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "04355b5c-c097-435a-8d61-7806b96c1ca0",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_02_BROWN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fbd0c091-8109-4035-b585-5eb206fc422c",
//                                                       "code": "MICROPLAN_MO_13_01_03_01_01_DIAHN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "1875b9de-fb92-4077-8985-a90b82191b1d",
//                                       "code": "MICROPLAN_MO_13_01_02_BEH_TOWN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "1c250c8c-8d3c-4730-9e69-64384b4d5aba",
//                                               "code": "MICROPLAN_MO_13_01_02_01_BEH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b6044065-74ea-416d-b155-53f5d1c32a6f",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_20_GRADY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "07ca4d84-a264-4c87-a3e4-1c4272427866",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_19_VLEGEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "acc43f92-c630-40eb-b455-8af87fe56a3e",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_18_GEYAH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4facf830-c997-4a6e-9555-c98d3fb3125d",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_17_MIDDLE_EAST",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd00bbe3-b9a8-4bd5-a52b-40d426165329",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_16_DEBOR_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7e9d9db2-b79e-485c-9134-294a4fde7900",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_15_KPOWEIN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "62f702e9-7fde-4cb4-a4d7-9210b41fbfe5",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_14_TOGBALEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "060f67f2-6e45-4fec-9713-e7c620110760",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_13_BODUO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1bd546db-08a9-451d-9775-9dd5e5af7c86",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_12_BEH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cf80208b-d701-4ee6-ba99-bdbd85be1eca",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_11_SINKON_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "21304a3d-f2e9-4464-889b-53a6eebfce33",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_10_WLUBOR_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0ae917e9-3d3c-45f6-825d-367cde3aa3dd",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_09_SAYDEE_VILLAGE_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bc70b4e1-ba9f-4408-ad14-339d7c37a9b7",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_08_GLOKPADEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a4bed0c5-dabb-40ff-83be-edbcb63b0cf3",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_07_BASSA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5680ab48-0b07-408a-ae59-68aa35e437d5",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_06_JULUTUZON2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "afeb0b32-4e68-48bb-8a42-9309daf4eef7",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_05_JULUTUZON1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9aeab96a-bcff-4450-8a15-f0fd60fa774f",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_04_KPAI_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "da8e3fc0-e9d6-4b53-b3bc-22b082debf9c",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_03_GLEPLAY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a4b897cf-13fe-4df6-a102-093a271ae09e",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_02_COMPOUND",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aa47c65e-fa87-47c4-a534-ff086da388f9",
//                                                       "code": "MICROPLAN_MO_13_01_02_01_01_ZAZA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "ef5a6584-09ea-4546-bd3f-b4f96f1b8b65",
//                                       "code": "MICROPLAN_MO_13_01_01_BARGBLOR_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "0d8d0c97-01ae-43d1-9829-c84174d79fdd",
//                                               "code": "MICROPLAN_MO_13_01_01_02_PENUNEWEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "670f15dd-5024-476b-b9bd-31b053f42c97",
//                                                       "code": "MICROPLAN_MO_13_01_01_02_05_BAYE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "565a0af6-63cc-4563-9def-2db969b191ed",
//                                                       "code": "MICROPLAN_MO_13_01_01_02_04_YOUGE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4afcc0d4-49a6-4eaa-bcd6-754dfe21a4d9",
//                                                       "code": "MICROPLAN_MO_13_01_01_02_03_PENUNEWEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a4d7a915-b0b6-458c-8c94-7a724d7ef8de",
//                                                       "code": "MICROPLAN_MO_13_01_01_02_02_VORWBLEE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0130d1c5-34c9-42c6-8faa-def341ae443c",
//                                                       "code": "MICROPLAN_MO_13_01_01_02_01_JAYOR_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "26225b57-ea00-4abd-967f-ae1471f257f7",
//                                               "code": "MICROPLAN_MO_13_01_01_01_BARGBLOR_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b5a1b7ca-86c9-43c2-ab89-1a231bc6711f",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_20_TENZON_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "80d8f826-8256-409a-9196-b8c6f0043b37",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_19_NICO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1ce76055-ad6b-4037-9a49-6795b3217a8c",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_18_JOSEPHUS_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2ef3abce-5551-4abc-bd9f-6e27cc322f9a",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_17_GEE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "59dc5017-3605-46dc-8652-f1d457e6a702",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_16_DEHYE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "24aecbc1-57fe-425e-b6a6-63dd7d81cd99",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_15_PETER_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "12cacca4-e439-4f78-996d-d26e3c8519aa",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_14_GAYE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "096b263e-8463-4b09-84b0-6cb7a8355b48",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_13_CAMROOM_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "24384618-c51a-4c6f-b50d-a2e92b009306",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_12_JOE_DENNIS_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "32881e51-54ca-44b5-a990-8ab5d23d5e35",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_11_SALAKAZON",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7d9a1416-96b8-48a8-a02e-e5fc7b4c61b4",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_10_COCODE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f9d43aa5-da78-4587-ae76-d943fa945f1f",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_09_BABLEE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49eb0aba-bd73-404b-8c26-3d0ad835cf3d",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_08_ONE_MAN_VI8LLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b47b9425-2d34-48a0-be90-df7be264f965",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_07_HARRIS_COLLIN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5e2854c8-48b5-4a12-aff5-3593520e2f7b",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_06_TOJALLAH_TOWN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2e8c8cfe-752c-48a2-9d3c-c9f3233b4445",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_05_TOJALLAH_TOWN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6015d066-fe0a-48fe-8f34-e1ee3c01fbd5",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_04_DOLUE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "94d9a65f-09e6-46c5-bc75-e3e6fb9c0e6d",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_03_BARGBLOR_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd360867-0496-4ab4-b3ec-9238c9d3ebec",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_02_MLAYEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b01911bf-eb05-4bb0-9204-eab768d6570e",
//                                                       "code": "MICROPLAN_MO_13_01_01_01_01_ZONPLEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "7e814eea-7dd3-4b76-9de7-41ec58c00e99",
//                       "code": "MICROPLAN_MO_12_GRAND_KRU",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "c5c62872-2f9d-402b-a44f-5224bc56c40f",
//                               "code": "MICROPLAN_MO_12_05_TREHN",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "17126d55-e885-4580-b10b-b3adb012cd9f",
//                                       "code": "MICROPLAN_MO_12_05_07_GBLEBO_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "dc1bd363-1fb5-4918-b223-55ac48fbcfc8",
//                                               "code": "MICROPLAN_MO_12_05_07_02_OLD_KARLAWAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c32076db-be4a-4640-9061-6126c7d6fb6d",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_09_TENDEKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a0ff9e8b-5f88-4d00-a243-44a6803dc3de",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_08_DOUGBOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f9acf8a5-c74d-4f55-83a9-690d602b94dd",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_07_DUTORKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "db48e0b6-7b98-4de9-8177-87f00bedb4c7",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_06_QUAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "20a606ac-4729-4ac5-8a9b-147367e8bf9f",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_05_TUNKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4011fcc3-6df6-4367-8e73-5cab76ec6e7d",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_04_NEW_KARLAWAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b030748b-c6dd-411c-95c5-146d20da012f",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_03_OLD_KARLAWAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f303f9c9-27c7-461d-81f4-6729eae5674c",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_02_SAYWONKEN_02",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "57df78d5-b1ea-445f-873a-222f52e6523e",
//                                                       "code": "MICROPLAN_MO_12_05_07_02_01_KWAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "26e23ef0-fe51-4306-addf-92d32641a324",
//                                               "code": "MICROPLAN_MO_12_05_07_01_GBLEBO_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b5979eaa-062e-4541-ba91-fdecc26e81f5",
//                                                       "code": "MICROPLAN_MO_12_05_07_01_01_GBLEBO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "a3e7a44c-600f-4e11-9d69-1a3afe016aec",
//                                       "code": "MICROPLAN_MO_12_05_06_NEWAKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b2027eb5-e58b-4823-b881-d0927f27c500",
//                                               "code": "MICROPLAN_MO_12_05_06_03_DOUGBO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f032af9a-17a9-405d-b1f5-13044262bf29",
//                                                       "code": "MICROPLAN_MO_12_05_06_03_03_GBARKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "47c10bc1-b6a7-4ec3-a04f-10e3c4e17c6b",
//                                                       "code": "MICROPLAN_MO_12_05_06_03_02_GEDEBO_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "db8c30d1-b6e5-4c03-af5f-60d977ede756",
//                                                       "code": "MICROPLAN_MO_12_05_06_03_01_DOUGBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "6592182f-2782-47a9-90b3-4459792e3c63",
//                                               "code": "MICROPLAN_MO_12_05_06_02_SORROKEN_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4162ffad-2709-4fa5-a95e-86f03a839a06",
//                                                       "code": "MICROPLAN_MO_12_05_06_02_03_WUTUKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a1178633-6eda-4afc-9f0b-84f3426f45a0",
//                                                       "code": "MICROPLAN_MO_12_05_06_02_02_GEDEBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3e5e0508-3ff5-4862-9bba-5d97ef1e140f",
//                                                       "code": "MICROPLAN_MO_12_05_06_02_01_SORROKEN_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "07cc34ff-3e37-45b0-b45d-376fd3731a6d",
//                                               "code": "MICROPLAN_MO_12_05_06_01_NEWAKEN_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "718a2908-2762-482e-a8b4-574b0f1588d4",
//                                                       "code": "MICROPLAN_MO_12_05_06_01_02_DIAYOKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "81f5ed18-da87-4df8-9cc8-22c805dcee6f",
//                                                       "code": "MICROPLAN_MO_12_05_06_01_01_NEWAKEN_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "882a4b16-c9a1-4a19-8d21-f4e471c985b7",
//                                       "code": "MICROPLAN_MO_12_05_05_BEHWAN_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "88a12aa0-90aa-4b90-9497-4d9a474aa610",
//                                               "code": "MICROPLAN_MO_12_05_05_03_KPOIKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "134fb9bd-00c6-434a-8fea-fe96d164bb2e",
//                                                       "code": "MICROPLAN_MO_12_05_05_03_06_KPOIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9b2b268b-f155-4e1b-b003-f0774fea1aed",
//                                                       "code": "MICROPLAN_MO_12_05_05_03_05_SAYWONKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "159f4277-d9cc-41af-944b-df100f1934be",
//                                                       "code": "MICROPLAN_MO_12_05_05_03_04_CHANGBENKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a9806a8a-00fa-4e0f-8f8e-9c82e20a8b86",
//                                                       "code": "MICROPLAN_MO_12_05_05_03_03_KULODEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ab72b85f-a006-4cf9-a7a8-79a597313d16",
//                                                       "code": "MICROPLAN_MO_12_05_05_03_02_QUENKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "92840fb7-4343-4d62-8a55-a1c39f3bdc99",
//                                                       "code": "MICROPLAN_MO_12_05_05_03_01_FOLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "ab629d2b-baac-48cf-94ac-85bb71c446e5",
//                                               "code": "MICROPLAN_MO_12_05_05_02_GBONOWINE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "fd8c9223-1fe9-499f-8e5d-e32c8767b9d6",
//                                                       "code": "MICROPLAN_MO_12_05_05_02_04_KWEBIE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7867f9f8-d6c4-48dd-beb0-0025c2014512",
//                                                       "code": "MICROPLAN_MO_12_05_05_02_03_SANGBANIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1ea1c4c0-2a4c-4aa8-b70a-9b8f20ff063f",
//                                                       "code": "MICROPLAN_MO_12_05_05_02_02_GBONOWINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d4ddeff3-1d30-45c7-a48d-38f2e7eea369",
//                                                       "code": "MICROPLAN_MO_12_05_05_02_01_SAWKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "164666ce-d8b1-486c-a2b1-4e242870bcab",
//                                               "code": "MICROPLAN_MO_12_05_05_01_BEHWAN_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "be0b5913-91d5-4247-95da-862d7d1ef014",
//                                                       "code": "MICROPLAN_MO_12_05_05_01_01_BEHWAN_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "e77803ec-7386-4875-8b44-c3f2955ddba9",
//                                       "code": "MICROPLAN_MO_12_05_04_NIFA_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "16a68f3f-b64c-4116-859d-ae5fd2a443a6",
//                                               "code": "MICROPLAN_MO_12_05_04_01_MIDDLE_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "30d085be-0355-4e63-89d0-b6faae06a35b",
//                                                       "code": "MICROPLAN_MO_12_05_04_01_05_MIDDLE_TOWN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2390fe57-a0c1-4ef6-a51c-79c429403143",
//                                                       "code": "MICROPLAN_MO_12_05_04_01_04_WEDABO_BEACH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7da3f621-49b6-43ad-818a-3aebee96e7d0",
//                                                       "code": "MICROPLAN_MO_12_05_04_01_03_WATER_SIDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "57da193f-a553-40ee-b604-782c9ba1bb5c",
//                                                       "code": "MICROPLAN_MO_12_05_04_01_02_JLORWIN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6b1f0f0a-3fd6-4415-a843-d02c851f777c",
//                                                       "code": "MICROPLAN_MO_12_05_04_01_01_BIG_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "b55e82f0-db7e-43f9-9005-2e54bf59a781",
//                                       "code": "MICROPLAN_MO_12_05_03_NEMIAH_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "013ecc0c-3af2-4a67-809e-4bbefae687b6",
//                                               "code": "MICROPLAN_MO_12_05_03_03_COFFIBEE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "d6e69dbf-a16d-4550-8b93-7841ffb2ad5e",
//                                                       "code": "MICROPLAN_MO_12_05_03_03_05_COFFIBEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc6dda17-cac7-4e60-aeaf-efd739d3968b",
//                                                       "code": "MICROPLAN_MO_12_05_03_03_04_DARPLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2aa52af3-4b15-4012-8186-36994f75c12d",
//                                                       "code": "MICROPLAN_MO_12_05_03_03_03_NEW_GBAMIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9fd15813-abef-4d8d-a058-1728dfe6bf05",
//                                                       "code": "MICROPLAN_MO_12_05_03_03_02_OLD_GBAMIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "76d328f3-45c2-4c9b-8173-39e719e0acf0",
//                                                       "code": "MICROPLAN_MO_12_05_03_03_01_TENDENKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "46482328-685e-4b09-b893-a741adef5492",
//                                               "code": "MICROPLAN_MO_12_05_03_02_PENNUKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "fcae4224-d718-43a4-b82d-29c31026c936",
//                                                       "code": "MICROPLAN_MO_12_05_03_02_05_NEMIAH_BEACH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f4250bb2-091d-4a4a-8c00-e5ef787c3b83",
//                                                       "code": "MICROPLAN_MO_12_05_03_02_04_PENNUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "26f35e5a-f500-4657-bfc1-eff1c4d55113",
//                                                       "code": "MICROPLAN_MO_12_05_03_02_03_ZOLUBEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e20df032-4903-4cf2-9098-5dc019b3cc8a",
//                                                       "code": "MICROPLAN_MO_12_05_03_02_02_GLOPLUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a192fb23-b3ec-4576-a115-994537a12150",
//                                                       "code": "MICROPLAN_MO_12_05_03_02_01_JLATIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "de156ece-6f1e-47c7-b838-bab8d38ade55",
//                                               "code": "MICROPLAN_MO_12_05_03_01_WILISONVILLE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "74aeb1ed-806d-41ed-8c02-3a73bf022515",
//                                                       "code": "MICROPLAN_MO_12_05_03_01_05_TUBIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b033a5f3-aa1c-4385-9834-ca1cfef09779",
//                                                       "code": "MICROPLAN_MO_12_05_03_01_04_GBAYOUBEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6f55170e-8ac5-472b-a859-4b6d11939416",
//                                                       "code": "MICROPLAN_MO_12_05_03_01_03_SLOLOH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6c046eed-0964-477d-90ca-5b29b69f9526",
//                                                       "code": "MICROPLAN_MO_12_05_03_01_02_JLAWLEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c598ba88-9395-40d7-aadf-249e61ab1e5c",
//                                                       "code": "MICROPLAN_MO_12_05_03_01_01_WILSONVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "171b4736-d610-46be-9a44-ecd0cd3a3790",
//                                       "code": "MICROPLAN_MO_12_05_02_GENOYAH_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a30e7f36-2655-489f-a272-d26abf119cd1",
//                                               "code": "MICROPLAN_MO_12_05_02_02_NYANBO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5fb1edf3-d44d-4427-8a52-df0edc27129e",
//                                                       "code": "MICROPLAN_MO_12_05_02_02_03_JLODEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "043940ae-4441-4dd1-b71e-ebd44b3b4459",
//                                                       "code": "MICROPLAN_MO_12_05_02_02_02_PIDDY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7ad7dfa7-0473-4f57-b35e-0dbad4495a46",
//                                                       "code": "MICROPLAN_MO_12_05_02_02_01_NYANBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "fa33737a-dace-4085-a913-fafb9a9523ee",
//                                               "code": "MICROPLAN_MO_12_05_02_01_GENOYAH_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "d410f73a-f68e-4b7f-9702-f73036378862",
//                                                       "code": "MICROPLAN_MO_12_05_02_01_03_YETIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "db2b0030-d3d6-476e-8c68-abe27ff9366f",
//                                                       "code": "MICROPLAN_MO_12_05_02_01_02_NEGBOWINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6e7faf75-0398-45c8-aaf4-c48e7ac521e6",
//                                                       "code": "MICROPLAN_MO_12_05_02_01_01_GENOYAH_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "a466379b-6306-4db7-a160-286efb26b68d",
//                                       "code": "MICROPLAN_MO_12_05_01_GARRAWAY_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "1cbd1f94-2416-4937-be76-8f7f132e33ba",
//                                               "code": "MICROPLAN_MO_12_05_01_03_TUWAKEN_1",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5cf7a313-b030-4f56-a8e2-e7e926ef4ca1",
//                                                       "code": "MICROPLAN_MO_12_05_01_03_04_TUWAKEN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9db30fa4-4703-4758-9bd7-a8cb97c77002",
//                                                       "code": "MICROPLAN_MO_12_05_01_03_03_TUWAKEN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "edcffdb0-d463-45ed-9ea8-b64b3063a279",
//                                                       "code": "MICROPLAN_MO_12_05_01_03_02_BACHEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ac8c4ddd-1626-4a25-b262-6b5edb192da5",
//                                                       "code": "MICROPLAN_MO_12_05_01_03_01_TEBEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "95c49a91-7dab-4021-981f-a37258dbe1a8",
//                                               "code": "MICROPLAN_MO_12_05_01_02_WETEKEN_1",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "fa2361ea-4ad4-43c4-b82c-032a23c51bc0",
//                                                       "code": "MICROPLAN_MO_12_05_01_02_02_WETEKEN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f470e4ac-6ce4-4074-8dfd-e2a4d747b8b7",
//                                                       "code": "MICROPLAN_MO_12_05_01_02_01_WETEKEN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "287fbd0d-428c-4c6c-83fc-161f0de3d727",
//                                               "code": "MICROPLAN_MO_12_05_01_01_NEW_GARRAWAY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "adb68d85-c8f6-4f6e-92e8-ba54d90de7de",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_08_PUNGBALOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3d4affae-f15a-41f3-9e64-92a798b563fa",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_07_MAHQUENKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "31cb2534-6ef3-4412-aae0-3ef62782c666",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_06_GBALEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "beb67d44-57c0-4032-adda-b8466cc8b138",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_05_HOSPITAL_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e77fb17a-1229-4ef7-b1d1-114023dd9251",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_04_SAYWONKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd9fa950-8fd5-4670-b2e9-b5d4ed9c56ea",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_03_MESSION_TOWN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "71295f95-865d-4a84-a252-a7827c84aa2f",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_02_MISSION_TOWN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "982dfcd5-bea5-439b-bc18-55d4dc2eb7bf",
//                                                       "code": "MICROPLAN_MO_12_05_01_01_01_NEW_GARRAWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "57e96e84-0a38-43cd-ba0b-496e6db31408",
//                               "code": "MICROPLAN_MO_12_04_LOWER_JLOH",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "5f5cdfee-89da-4ecd-906e-b37290a9139f",
//                                       "code": "MICROPLAN_MO_12_04_03_NIFU_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f314f45c-89aa-41ca-b468-1156a793aa51",
//                                               "code": "MICROPLAN_MO_12_04_03_02_BOTRA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b9d89afb-c88b-4e22-a406-ae350ce43cbf",
//                                                       "code": "MICROPLAN_MO_12_04_03_02_03_UNITED_BASE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bf3a8bd0-8390-4564-9bed-1cebc1d33dac",
//                                                       "code": "MICROPLAN_MO_12_04_03_02_02_DIOH_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bdfa6dda-40f2-44bd-9f42-fd24e1d63a96",
//                                                       "code": "MICROPLAN_MO_12_04_03_02_01_BOTRA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "f8b52b96-c010-42eb-a5d5-afdf32c0cc4f",
//                                               "code": "MICROPLAN_MO_12_04_03_01_NIFU_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "28e32976-0ed9-42c1-9144-5d5a783d95ab",
//                                                       "code": "MICROPLAN_MO_12_04_03_01_01_NIFU_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "c554fd46-249a-42dc-82b3-34e6719d4acd",
//                                       "code": "MICROPLAN_MO_12_04_02_SOBO_COMMUNITY_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "c400e1f9-5316-49d0-9cdd-dc2380166222",
//                                               "code": "MICROPLAN_MO_12_04_02_02_NEROH",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "475f5aa7-1928-43a8-a0c1-2cfbc6ef2450",
//                                                       "code": "MICROPLAN_MO_12_04_02_02_03_KARH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7b35bdcc-7ea4-4173-8422-f24f7d644616",
//                                                       "code": "MICROPLAN_MO_12_04_02_02_02_WESSEHPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7bca09d8-fb44-4193-b1f3-2c84f593d50a",
//                                                       "code": "MICROPLAN_MO_12_04_02_02_01_NEROH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "6adaade2-8769-417f-ad03-645ab7016d73",
//                                               "code": "MICROPLAN_MO_12_04_02_01_SOBO_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b27a4e97-3b1e-4c46-b451-8aefa76fe4ab",
//                                                       "code": "MICROPLAN_MO_12_04_02_01_02_PITTAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "752fd6e6-0747-4622-9fb2-fd5dd041bd78",
//                                                       "code": "MICROPLAN_MO_12_04_02_01_01_SOBO_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "24d21d87-dac0-4230-8b36-b4bd53e428f7",
//                                       "code": "MICROPLAN_MO_12_04_01_SASS_TOWN_HOSPITAL",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "0c327fea-5f85-4758-8bef-5861eb385658",
//                                               "code": "MICROPLAN_MO_12_04_01_05_VALLA_ROCK_FIELD",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "34002cdd-a23d-4762-bd2a-883f19e478f8",
//                                                       "code": "MICROPLAN_MO_12_04_01_05_02_ARAB_BASED",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "07a94851-d8e2-4d7c-b08c-17ad31e16186",
//                                                       "code": "MICROPLAN_MO_12_04_01_05_01_VALLA_ROCK_FIELD",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "840adf6d-02cd-428e-bf1c-ff3e928c8b61",
//                                               "code": "MICROPLAN_MO_12_04_01_04_WESSEH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "36c8c392-f9c3-4d1f-8156-1fd6ff000c40",
//                                                       "code": "MICROPLAN_MO_12_04_01_04_04_KITTEAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "44f34c5a-5a4b-49c5-ad09-fac5886f3bb4",
//                                                       "code": "MICROPLAN_MO_12_04_01_04_03_BASSA_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3f0117dd-698c-4239-bbe5-0e54ba3871c5",
//                                                       "code": "MICROPLAN_MO_12_04_01_04_02_SLOYEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "09d6fd88-a8da-4c7a-86df-b947b268d5c5",
//                                                       "code": "MICROPLAN_MO_12_04_01_04_01_WESSEH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "5ac5d6f3-0a53-4406-90c4-a8f70e7d1e7d",
//                                               "code": "MICROPLAN_MO_12_04_01_03_NROKWIA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "46cde6cf-87cc-423e-897a-1f9d4bf3ba70",
//                                                       "code": "MICROPLAN_MO_12_04_01_03_04_WLOKRI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a79e8e48-85a3-4c04-83ec-b57c68eb3c53",
//                                                       "code": "MICROPLAN_MO_12_04_01_03_03_KUNNIE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2d9f6dc9-b21c-4395-b84d-84f45e8b6bab",
//                                                       "code": "MICROPLAN_MO_12_04_01_03_02_KLADIA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "60dd48e8-81d0-4069-8228-5818aeea9ab7",
//                                                       "code": "MICROPLAN_MO_12_04_01_03_01_NROKWIA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "3f55c737-a6b9-4a47-9e16-b8020ff1c8f1",
//                                               "code": "MICROPLAN_MO_12_04_01_02_DAYKPO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ac8d0ffe-0b59-4a85-acfb-e306e5def713",
//                                                       "code": "MICROPLAN_MO_12_04_01_02_03_SOBOBO_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a8de0809-24ec-4891-92a9-7b68eb523dd8",
//                                                       "code": "MICROPLAN_MO_12_04_01_02_02_BETU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0bd317cb-be4b-41dd-b416-6f2ce62ec3e4",
//                                                       "code": "MICROPLAN_MO_12_04_01_02_01_DAYKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "4f59dffb-94c4-4e35-b885-d4095edb5f55",
//                                               "code": "MICROPLAN_MO_12_04_01_01_JEKWIKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8321d679-8e16-4d64-9808-760b0cc9e325",
//                                                       "code": "MICROPLAN_MO_12_04_01_01_03_JEKWIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9264e198-d52e-47ca-81f1-57b2b4174260",
//                                                       "code": "MICROPLAN_MO_12_04_01_01_02_DARGBEVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "43fe4419-5722-48c6-981e-25ab2884f7ca",
//                                                       "code": "MICROPLAN_MO_12_04_01_01_01_FELORKLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "c07394a6-97f3-47a8-a906-ffecbe02d9cc",
//                               "code": "MICROPLAN_MO_12_03_DORBOR",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "d436a68b-51eb-421c-9e4c-80f70594173a",
//                                       "code": "MICROPLAN_MO_12_03_03_DOESWEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "98110765-a82c-4dbc-b372-4551dabbaaa6",
//                                               "code": "MICROPLAN_MO_12_03_03_03_WEAYAN_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "79554f7c-ae5b-48f3-8234-67c4990f539d",
//                                                       "code": "MICROPLAN_MO_12_03_03_03_02_SEEBODRO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ab69d173-48aa-4c24-a927-022870747c18",
//                                                       "code": "MICROPLAN_MO_12_03_03_03_01_WEAYAN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "e028f2d9-79ea-4c1b-a87c-f824669714b5",
//                                               "code": "MICROPLAN_MO_12_03_03_02_BOLLOH_JLATIKEN_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a7d8946a-a8b4-43fa-b7a7-50f024d359fb",
//                                                       "code": "MICROPLAN_MO_12_03_03_02_03_DAYBAH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0700afa0-e17d-4da0-996c-a198c0398d0a",
//                                                       "code": "MICROPLAN_MO_12_03_03_02_02_CHENGBETEE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3c8ed4d3-4f26-4342-92e3-fba4ac8cd225",
//                                                       "code": "MICROPLAN_MO_12_03_03_02_01_BOLLOH_JLATIKEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "85cbd936-5f41-4c61-ab6f-770c6168462c",
//                                               "code": "MICROPLAN_MO_12_03_03_01_DOESWEN_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6715b6ee-7458-4ab6-885a-dee6f127d5df",
//                                                       "code": "MICROPLAN_MO_12_03_03_01_03_WARWLEKEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "acd6a110-24ed-495c-a50c-2cb467acaffd",
//                                                       "code": "MICROPLAN_MO_12_03_03_01_02_ATLANTIC_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ada96afe-0411-4729-bf60-ca97cd5e77d1",
//                                                       "code": "MICROPLAN_MO_12_03_03_01_01_DOESWEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "355e7735-8bd2-488b-a1ca-defe2bcbba1e",
//                                       "code": "MICROPLAN_MO_12_03_02_BOLLOH_NEWTOWN",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d8e58b47-1ce0-4129-8fa0-875b7fe6c7bd",
//                                               "code": "MICROPLAN_MO_12_03_02_03_NIMEYOUVILLE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "73834d5f-4a3a-4d2d-abf9-e3a5b36c963b",
//                                                       "code": "MICROPLAN_MO_12_03_02_03_02_BEFORE_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5389c218-85b0-4e01-8e9a-f90c137cf3dd",
//                                                       "code": "MICROPLAN_MO_12_03_02_03_01_NIMEYOUVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "2192f8b6-b6dd-44b5-a95d-ae8a4bbd6c61",
//                                               "code": "MICROPLAN_MO_12_03_02_02_WARKPO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "146f0b2b-dcf1-4179-a9a3-8ad35fcef721",
//                                                       "code": "MICROPLAN_MO_12_03_02_02_02_NIPLAIKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7cc96fc8-6d24-4000-bfe1-9c75d9e61d86",
//                                                       "code": "MICROPLAN_MO_12_03_02_02_01_WARKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "4f6c152b-2a5f-4241-b4cc-22aa7037ffb6",
//                                               "code": "MICROPLAN_MO_12_03_02_01_NEWTOWN_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9a47ab1b-e962-417e-8ed1-6d1583a592a7",
//                                                       "code": "MICROPLAN_MO_12_03_02_01_01_NEWTOWN_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "59473cb7-a547-4992-94a9-492a7ae26f49",
//                                       "code": "MICROPLAN_MO_12_03_01_NYANKUNPO_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d7fa7a6b-a3f5-4023-aa05-f9cff69735f0",
//                                               "code": "MICROPLAN_MO_12_03_01_03_JARKAKPO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "3c33dc17-20f8-49e6-af87-0b6d3480eda7",
//                                                       "code": "MICROPLAN_MO_12_03_01_03_03_KLAYDEEPER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "01fb0b1c-1f04-4d9f-b6b9-8724336b23b8",
//                                                       "code": "MICROPLAN_MO_12_03_01_03_02_KAYKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "04c20939-1a44-4abe-87ac-eebbff7aed42",
//                                                       "code": "MICROPLAN_MO_12_03_01_03_01_JARKAKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "427d8cf4-ecfe-4738-8096-af77931dc45b",
//                                               "code": "MICROPLAN_MO_12_03_01_02_BARFORWIN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0a635d2c-c436-487a-b299-f07d0c0f1db0",
//                                                       "code": "MICROPLAN_MO_12_03_01_02_02_BOLLOH_POE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0eb66530-0c82-41ba-b58e-00cf0f9e0de1",
//                                                       "code": "MICROPLAN_MO_12_03_01_02_01_BARFORWIN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "625c9604-130c-421c-aeb8-6c19ae1f2e06",
//                                               "code": "MICROPLAN_MO_12_03_01_01_NYANKUNPO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e33e36eb-0b76-4523-b7f1-70ff4a36c067",
//                                                       "code": "MICROPLAN_MO_12_03_01_01_02_PUTU_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "15fb3a37-d603-432f-9d9e-5486d1547706",
//                                                       "code": "MICROPLAN_MO_12_03_01_01_01_NYANKUNPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "bcc67783-6c1d-494c-bb75-858b2a1662c6",
//                               "code": "MICROPLAN_MO_12_02_BUAH",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "779666a0-1bf7-4a7d-b84e-8c5c82056764",
//                                       "code": "MICROPLAN_MO_12_02_04_PONNOKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d35cdef8-7819-453b-a825-feb424c19092",
//                                               "code": "MICROPLAN_MO_12_02_04_02_PARLUKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a4c985f1-154f-4b25-b20d-9b0a2e7e748c",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_12_BOLUWIN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "117d22ac-f7b5-4d8c-aa5a-9d55910e900f",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_11_JUDANYAN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d2328492-0b12-4710-8898-b2402a47f6ce",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_10_MA_MARY_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e33221af-dd0c-4035-8a58-d43126acb98c",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_09_E_MAN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6bdd3202-2199-4834-add1-0f0e8a504dd4",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_08_SARTIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cd88c45a-4d89-46d6-87c4-8cfeb18215a9",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_07_CAMP_SUCCESS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5ff4a1bb-1aee-42fc-8a01-46a257f8c1aa",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_06_PLACE_TO_BE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "74e82727-3793-405c-b739-e1d41c99e513",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_05_CAMP_SCOTTLAND",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fdc4278c-f15d-4ba2-870b-0da07e914df9",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_04_CHWNBOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f7062aac-1934-4fe1-8e40-335d268bf7bb",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_03_CAMP_SPAIN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "17319c0b-1a72-4dec-aa1b-580aa249c4ed",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_02_JLABAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6d358b38-f48e-4f9f-a94d-12b1dc4bb44c",
//                                                       "code": "MICROPLAN_MO_12_02_04_02_01_PARLUKEN1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "9b7be80d-eac9-40c2-a931-8e146a15b0dc",
//                                               "code": "MICROPLAN_MO_12_02_04_01_WROPLUKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f76e0c8d-0074-4444-ae2c-a1de9e86a050",
//                                                       "code": "MICROPLAN_MO_12_02_04_01_02_WROPLUKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "be86ae0a-8b99-41b7-a245-c0017a3db959",
//                                                       "code": "MICROPLAN_MO_12_02_04_01_01_GBARKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f431442e-5b00-4ea4-92b7-06245dda5176",
//                                       "code": "MICROPLAN_MO_12_02_03_TARLU_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "02377306-7ecc-4bb7-9467-244b15087228",
//                                               "code": "MICROPLAN_MO_12_02_03_02_PLANPLANKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7e3a2d72-4ffa-4000-86fc-748603dd64e6",
//                                                       "code": "MICROPLAN_MO_12_02_03_02_04_SARBEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e73d86da-00d4-4247-852a-16feb1732d8b",
//                                                       "code": "MICROPLAN_MO_12_02_03_02_03_WREKEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9fd12501-cf3c-4baa-a813-a91c7078f158",
//                                                       "code": "MICROPLAN_MO_12_02_03_02_02_WOLOKEN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "14965f88-6c02-48cb-8184-13eadcb8b64a",
//                                                       "code": "MICROPLAN_MO_12_02_03_02_01_PLANPLANKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "d9704d5b-5695-4d89-a870-4b76142b88f6",
//                                               "code": "MICROPLAN_MO_12_02_03_01_JERBOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9f1c0dd6-4305-42a4-a82f-e63cf16b4845",
//                                                       "code": "MICROPLAN_MO_12_02_03_01_02_JLATEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bca3df0e-77b1-45bf-a26e-0a5bbd9bf8d9",
//                                                       "code": "MICROPLAN_MO_12_02_03_01_01_JERBOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "29ad8ea8-6a0e-4f56-9136-41bb1fb7637f",
//                                       "code": "MICROPLAN_MO_12_02_02_DWEKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "de7b4df9-b06e-4647-9f1e-00af90e37b03",
//                                               "code": "MICROPLAN_MO_12_02_02_02_JABLAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c10ed8a0-ab36-496e-a6ec-71701c41ef35",
//                                                       "code": "MICROPLAN_MO_12_02_02_02_03_SARKPA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8f416cde-84fa-4bb8-b8f6-529e607c44dd",
//                                                       "code": "MICROPLAN_MO_12_02_02_02_02_GBASULUKU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3a9c637e-bab1-482b-b47e-06df145990c2",
//                                                       "code": "MICROPLAN_MO_12_02_02_02_01_JABLAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "6bc84c00-f97a-4a43-8caa-10e82ea71c8a",
//                                               "code": "MICROPLAN_MO_12_02_02_01_DWEKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7875c0df-12cc-40a3-8d1d-489c25447167",
//                                                       "code": "MICROPLAN_MO_12_02_02_01_02_PHILIDEPHEDIA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5bd5d8d1-5763-4fce-9b27-7096bde175ed",
//                                                       "code": "MICROPLAN_MO_12_02_02_01_01_DWEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "48e50053-2e9b-42ff-9add-0fa2027adcc5",
//                                       "code": "MICROPLAN_MO_12_02_01_BUAH_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "7434e139-88ad-459e-9b70-ceb87e2d9dab",
//                                               "code": "MICROPLAN_MO_12_02_01_05_ANAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "79f16452-d51d-4d91-a843-43ff81412b99",
//                                                       "code": "MICROPLAN_MO_12_02_01_05_01_ANAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "1a375f25-8490-4c8c-acd1-02755436d970",
//                                               "code": "MICROPLAN_MO_12_02_01_04_SMITHVILLE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "1259b76e-42bd-49eb-ba7f-a9513bd9a9b8",
//                                                       "code": "MICROPLAN_MO_12_02_01_04_01_SMITHVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "7ac7652c-c8e2-4ef0-8a2e-7f3ed2d19510",
//                                               "code": "MICROPLAN_MO_12_02_01_03_SIAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5eee010c-d2ac-4ea7-ae68-aab3bc6fd962",
//                                                       "code": "MICROPLAN_MO_12_02_01_03_03_TAYBUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dca79286-392f-4ba6-84a5-615b39b85b6e",
//                                                       "code": "MICROPLAN_MO_12_02_01_03_02_TARWROKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "063769b3-2f15-4251-a6de-82e55a5da6b5",
//                                                       "code": "MICROPLAN_MO_12_02_01_03_01_SIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "ad83bb33-4711-4a73-8686-353d828ba54b",
//                                               "code": "MICROPLAN_MO_12_02_01_02_DIAYOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b2e22fd6-e8d5-490e-b7ce-baabb4a9d023",
//                                                       "code": "MICROPLAN_MO_12_02_01_02_03_WOLOKEN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ee67e517-7ec8-4cb3-ba23-ae11c1755e26",
//                                                       "code": "MICROPLAN_MO_12_02_01_02_02_DIAYOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7d0ea7ce-7d7c-4a33-be39-865a32fe6f52",
//                                                       "code": "MICROPLAN_MO_12_02_01_02_01_TUBUVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "662a1577-4c12-46e2-9c7a-5102bead1a48",
//                                               "code": "MICROPLAN_MO_12_02_01_01_CHENWRIKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6bedffba-a6de-46d4-8e7c-c529fc570f50",
//                                                       "code": "MICROPLAN_MO_12_02_01_01_03_WROPLUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ae0ed0c7-13dd-407a-a45a-0eb0deeba6f3",
//                                                       "code": "MICROPLAN_MO_12_02_01_01_02_TARKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e1a04f7d-ede1-4664-89d3-b72dd49313fc",
//                                                       "code": "MICROPLAN_MO_12_02_01_01_01_CHENWRIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "f9143bee-31b8-4096-8c18-67060c88a0c2",
//                               "code": "MICROPLAN_MO_12_01_BARCLAYVILLE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "20f3d781-d43c-4d1c-b2bb-91facb1f0e24",
//                                       "code": "MICROPLAN_MO_12_01_06_GBANKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "84da28ac-03d7-40d1-8636-a4a22b1bceef",
//                                               "code": "MICROPLAN_MO_12_01_06_05_KWEYEKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c9929e3a-fbdb-45eb-a265-fec5d208b26c",
//                                                       "code": "MICROPLAN_MO_12_01_06_05_04_KAYBOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "17a16822-6f9e-4db6-bdfc-b18778f6cd68",
//                                                       "code": "MICROPLAN_MO_12_01_06_05_03_MUYANKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b46ef080-d1f2-4fe9-ab02-b510211e2518",
//                                                       "code": "MICROPLAN_MO_12_01_06_05_02_TUPOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9b18be8d-a09e-4f1a-9f35-ffa277df4a1f",
//                                                       "code": "MICROPLAN_MO_12_01_06_05_01_KWEYEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "9e26e132-3aca-4e98-b982-46fd42e3bf9b",
//                                               "code": "MICROPLAN_MO_12_01_06_04_GBLABLOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0527826c-852c-4743-afd9-a49d7331ee3c",
//                                                       "code": "MICROPLAN_MO_12_01_06_04_03_TARPLAH_S_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "97aeec57-b7c6-4117-96f4-ccad4b756cec",
//                                                       "code": "MICROPLAN_MO_12_01_06_04_02_JLAROKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "38a2689b-1fa5-466d-93b2-01e4a0f4c438",
//                                                       "code": "MICROPLAN_MO_12_01_06_04_01_GBLABLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "04668ce8-cbe3-4890-a21c-34baaec56143",
//                                               "code": "MICROPLAN_MO_12_01_06_03_GENEKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a19f3366-263a-48d2-ac2e-f994a4142879",
//                                                       "code": "MICROPLAN_MO_12_01_06_03_03_WEDABOBEHWAN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e7cf291f-8eb5-4a81-8f98-71f026aaeb8d",
//                                                       "code": "MICROPLAN_MO_12_01_06_03_02_DENTIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9f5c6d76-5986-4a40-9cb4-a4ada2d6e42a",
//                                                       "code": "MICROPLAN_MO_12_01_06_03_01_GENEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "d60590ca-b05f-4631-b036-28dfa8958cf0",
//                                               "code": "MICROPLAN_MO_12_01_06_02_ZOLOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f924cf87-93f3-4329-a344-6e57e7f5a70b",
//                                                       "code": "MICROPLAN_MO_12_01_06_02_02_KWELEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d71c1189-375b-4278-af81-412e2ddb633f",
//                                                       "code": "MICROPLAN_MO_12_01_06_02_01_ZOLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "4e864c04-e9c5-4458-af52-d0f61874a301",
//                                               "code": "MICROPLAN_MO_12_01_06_01_GBANKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "67c1c7cc-1eba-43b7-bce9-68f5744500e2",
//                                                       "code": "MICROPLAN_MO_12_01_06_01_02_YLATWEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a0229ed8-36b4-4904-9782-e64a1bb56dc5",
//                                                       "code": "MICROPLAN_MO_12_01_06_01_01_GBANKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "5a16d4d3-1d9f-452a-adf0-b62f5ed5c10b",
//                                       "code": "MICROPLAN_MO_12_01_05_RALLY_TIME_HOSPITAL",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "698cb6e6-8548-4831-b4d4-62a26dde6edc",
//                                               "code": "MICROPLAN_MO_12_01_05_02_NEWCESS",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b616e123-4896-4005-a7a5-ab52eb2ef546",
//                                                       "code": "MICROPLAN_MO_12_01_05_02_03_BELLORKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ec0d5ec7-02ad-4f94-aa4c-ba3301e700d1",
//                                                       "code": "MICROPLAN_MO_12_01_05_02_02_GBANKEN_BEACH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3c089ecd-cd35-48d6-9da3-6bf2db26cf62",
//                                                       "code": "MICROPLAN_MO_12_01_05_02_01_NEWCESS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "75dc6829-060f-4c81-9e47-e34d6db6f9f4",
//                                               "code": "MICROPLAN_MO_12_01_05_01_GRAND_CESS_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "68023af6-d793-4985-8b97-6106f6f96998",
//                                                       "code": "MICROPLAN_MO_12_01_05_01_01_GRAND_CESS_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f32daab0-1073-430d-a456-d17425433962",
//                                       "code": "MICROPLAN_MO_12_01_04_BARCLAYVILLE_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a6a3a8bc-f1cd-42c1-a728-8dcdbf638b71",
//                                               "code": "MICROPLAN_MO_12_01_04_04_BIG_FLENEKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ddcae296-5ddf-4099-bbe5-564289632648",
//                                                       "code": "MICROPLAN_MO_12_01_04_04_02_WUTUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dd44b5b1-4a58-4793-8f02-39561749aa4d",
//                                                       "code": "MICROPLAN_MO_12_01_04_04_01_BIG_FLENEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "10ff1e08-225a-43bd-8adf-2ecb8e6a7695",
//                                               "code": "MICROPLAN_MO_12_01_04_03_TOPOH",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "52b5b80d-24ae-4bb0-88b8-e6d1b11e40e8",
//                                                       "code": "MICROPLAN_MO_12_01_04_03_02_BIG_SUEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7f32dc92-f536-4fe7-bcda-fd88fc33939b",
//                                                       "code": "MICROPLAN_MO_12_01_04_03_01_TOPOH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "01f3998a-0586-44e5-b4ec-24930b20f629",
//                                               "code": "MICROPLAN_MO_12_01_04_02_WAKPEKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "3c5ba20c-65b1-484c-b235-168507c8eed8",
//                                                       "code": "MICROPLAN_MO_12_01_04_02_02_SEATOR_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "edc151c9-9272-4c3f-a215-0080387296ba",
//                                                       "code": "MICROPLAN_MO_12_01_04_02_01_WAKPEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "c69c89f3-2d91-4992-8935-46d288fa81dc",
//                                               "code": "MICROPLAN_MO_12_01_04_01_ZONE_ONE_HOSPITAL_CAMP",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8b9a116a-7542-43cb-8f2d-27374fa771e9",
//                                                       "code": "MICROPLAN_MO_12_01_04_01_05_KAYKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cd2c309a-d770-4883-a621-f24f5472a5a4",
//                                                       "code": "MICROPLAN_MO_12_01_04_01_04_SEDEE_COMPOUND",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7843c915-aec8-4a5b-b161-c91443ab2124",
//                                                       "code": "MICROPLAN_MO_12_01_04_01_03_GREEN_HILL",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0b9d824d-814f-40c0-bb4f-5de44a223d58",
//                                                       "code": "MICROPLAN_MO_12_01_04_01_02_CAMP_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "016a3cb8-efbf-4033-9df5-8e3e653dc658",
//                                                       "code": "MICROPLAN_MO_12_01_04_01_01_ZONE_ONE_HOSPITAL_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "fcdf5642-494b-45fd-a1cf-b9ea69b86fec",
//                                       "code": "MICROPLAN_MO_12_01_03_JUDUKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "7f9f43da-c4d7-4fc4-859b-89c4606efa65",
//                                               "code": "MICROPLAN_MO_12_01_03_03_TUPAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f903b337-c6c2-4336-b561-e509148d3eda",
//                                                       "code": "MICROPLAN_MO_12_01_03_03_03_CHANGBEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a8870b78-97d1-4c05-b023-f0b747ca05a5",
//                                                       "code": "MICROPLAN_MO_12_01_03_03_02_SORROKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d9ad8448-83c2-4399-bd4b-53defabe1910",
//                                                       "code": "MICROPLAN_MO_12_01_03_03_01_TUPAKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "59c0b897-ce3b-48e2-b5ae-2ba98de3fb6d",
//                                               "code": "MICROPLAN_MO_12_01_03_02_GBEBOR",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "09ac54a6-4140-4b22-9040-c9891c8603f7",
//                                                       "code": "MICROPLAN_MO_12_01_03_02_05_PANWENKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7657b7f9-b068-42e7-846c-2a367defab40",
//                                                       "code": "MICROPLAN_MO_12_01_03_02_04_UPPER_NEMIAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "614d461e-2d41-4251-b1ec-5f5774f85617",
//                                                       "code": "MICROPLAN_MO_12_01_03_02_03_ISLAND_NEMIAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c798ee27-3eb1-4719-9721-ce8bcf793ffb",
//                                                       "code": "MICROPLAN_MO_12_01_03_02_02_DEGBLAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "29618c3d-debf-491c-b06b-2d909a799426",
//                                                       "code": "MICROPLAN_MO_12_01_03_02_01_GBEBOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "4f82265f-9c59-49e4-9272-f4aaa7abe48c",
//                                               "code": "MICROPLAN_MO_12_01_03_01_JUDUKEN_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "1e5d3c23-fd75-4fb3-8061-0013d77a16d5",
//                                                       "code": "MICROPLAN_MO_12_01_03_01_03_DUDUBOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6d6cd964-4bf4-498d-87a5-4025e70e877d",
//                                                       "code": "MICROPLAN_MO_12_01_03_01_02_GBEWIEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8407a707-5aef-4827-a18d-64fbce436b4a",
//                                                       "code": "MICROPLAN_MO_12_01_03_01_01_JUDUKEN_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "6c9b6e57-2900-4ccf-9bd4-952ba0e23d6c",
//                                       "code": "MICROPLAN_MO_12_01_02_PICNECESS_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "c65ea8d1-f380-4890-b44c-a5fcc583d981",
//                                               "code": "MICROPLAN_MO_12_01_02_03_SOLOKPO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "68503a51-25bb-41c8-bacb-fb3c96d18a91",
//                                                       "code": "MICROPLAN_MO_12_01_02_03_04_TARAWA_VILAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c9c8d741-cc94-4a30-8ca0-ed4b2d5590e5",
//                                                       "code": "MICROPLAN_MO_12_01_02_03_03_JAKAKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7db9fc79-5f43-439f-91e4-16fa96eb4110",
//                                                       "code": "MICROPLAN_MO_12_01_02_03_02_SOBOBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9f8cb259-b5d1-41b4-a2b1-409c2a224148",
//                                                       "code": "MICROPLAN_MO_12_01_02_03_01_SOLOKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "b0496169-e6bf-49a1-abd9-1f492600644a",
//                                               "code": "MICROPLAN_MO_12_01_02_02_KLOFUEH",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e6ec7e4a-fdd3-4b1b-9f40-0e2bbe35a360",
//                                                       "code": "MICROPLAN_MO_12_01_02_02_03_TOGBAKLEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b7384ab1-e2c6-4126-88e0-7ef4fee2923d",
//                                                       "code": "MICROPLAN_MO_12_01_02_02_02_JLATEKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2d856619-a9dc-4067-af16-bb58a272ef19",
//                                                       "code": "MICROPLAN_MO_12_01_02_02_01_KLOFUEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "559af813-88b0-4d04-9426-ffcc6aff7c78",
//                                               "code": "MICROPLAN_MO_12_01_02_01_BAILAKPO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5871c7f0-d10b-41a8-a361-76d6aa88503f",
//                                                       "code": "MICROPLAN_MO_12_01_02_01_03_FUNKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "00ad916b-8c9c-4663-bd24-3bdef2cf01c6",
//                                                       "code": "MICROPLAN_MO_12_01_02_01_02_BONGALO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "80a524b1-5b14-4b8d-8bda-786e0477ad1b",
//                                                       "code": "MICROPLAN_MO_12_01_02_01_01_BAILAKPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "a1ad0b66-1d37-4942-9057-192df0357204",
//                                       "code": "MICROPLAN_MO_12_01_01_GBALAKPO_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f0e90dcc-fbac-4d4b-a3ad-599260dbcef8",
//                                               "code": "MICROPLAN_MO_12_01_01_03_GENWIEN_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "162a4b6b-ec5e-4e45-b813-b6c072c07eed",
//                                                       "code": "MICROPLAN_MO_12_01_01_03_03_DWATRO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dfa25d05-ac26-4786-a849-e8df4d80f162",
//                                                       "code": "MICROPLAN_MO_12_01_01_03_02_OTIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "abd06151-4e66-4038-95bb-8e68b61c865b",
//                                                       "code": "MICROPLAN_MO_12_01_01_03_01_GENWIEN_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "f731d440-08e8-48f6-a8bf-71e382863f4e",
//                                               "code": "MICROPLAN_MO_12_01_01_02_JOPLOKEN_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "84a1dad3-1ec2-476b-8241-d38feab125eb",
//                                                       "code": "MICROPLAN_MO_12_01_01_02_03_TUTUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d39d1361-d232-4450-ba10-e7dd888cf2d0",
//                                                       "code": "MICROPLAN_MO_12_01_01_02_02_KANWEAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bfb2170c-55b2-4d35-ac56-fed19f2bbdbd",
//                                                       "code": "MICROPLAN_MO_12_01_01_02_01_JOPLOKEN_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "593d0538-6a28-442b-b07a-a5d18f72ab90",
//                                               "code": "MICROPLAN_MO_12_01_01_01_FILORKEN_CITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "dbfbb6a5-4c5d-47d4-8c00-b0c372740321",
//                                                       "code": "MICROPLAN_MO_12_01_01_01_02_GBUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f5746caf-3ccf-49b5-a3d0-0c5c6f3fa771",
//                                                       "code": "MICROPLAN_MO_12_01_01_01_01_FILORKEN_CITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "5ad1cb7b-3e41-43c6-8421-65fd75081017",
//                       "code": "MICROPLAN_MO_11_MARYLAND",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "1da6af32-8f0a-4277-8105-2c8e68dcdcc2",
//                               "code": "MICROPLAN_MO_11_06_PLEEBO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "76e151ec-1aab-4907-82b7-fe38e8069be2",
//                                       "code": "MICROPLAN_MO_11_06_05_PLEEBO_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "838b0260-bc58-408a-8863-46c37e32916e",
//                                               "code": "MICROPLAN_MO_11_06_05_14_HOSPITAL_CAMP_CAMP_3",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "27429070-dc7c-4539-b0ad-adb427fc9b65",
//                                                       "code": "MICROPLAN_MO_11_06_05_14_03_HOSPITAL_CAMP_CAMP_5_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c511e9fc-aa6f-4516-87a2-67b8626cdcd0",
//                                                       "code": "MICROPLAN_MO_11_06_05_14_02_FACTORY_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "644bbf73-dbce-4a02-8391-854ba4a540f3",
//                                                       "code": "MICROPLAN_MO_11_06_05_14_01_HOSPITAL_CAMP_CAMP_3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "9978f6ea-ea66-4488-bf07-2b861917efdb",
//                                               "code": "MICROPLAN_MO_11_06_05_13_GEDETARBO_8",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "11bdaf4a-34a3-428c-b043-54e236eec4c4",
//                                                       "code": "MICROPLAN_MO_11_06_05_13_01_GEDETARBO_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "5344a815-ab4e-4625-9bd8-b383fa88102b",
//                                               "code": "MICROPLAN_MO_11_06_05_12_GEDETARBO_7",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "dedb5430-1547-444f-b615-ec2ce4ab4643",
//                                                       "code": "MICROPLAN_MO_11_06_05_12_01_GEDETARBO_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "d534d05d-c510-497d-ae90-ab07aabd9397",
//                                               "code": "MICROPLAN_MO_11_06_05_11_GEDETARBO_6",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "374033e8-437d-42aa-b3c9-b19b1ce1e9c1",
//                                                       "code": "MICROPLAN_MO_11_06_05_11_01_RUBBER_BED",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "3b40fe8d-242d-44db-b3a2-328444a88301",
//                                               "code": "MICROPLAN_MO_11_06_05_10_GEDETARBO_5",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "36182e1a-eaab-4221-a21c-7702dd0318ba",
//                                                       "code": "MICROPLAN_MO_11_06_05_10_01_TOGBA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "68360c5a-7dd1-42f5-9949-bb6635f26b21",
//                                               "code": "MICROPLAN_MO_11_06_05_09_GEDETARBO_4",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e224efb7-046f-49b5-b5ba-89dd59114186",
//                                                       "code": "MICROPLAN_MO_11_06_05_09_01_NEMEKEN_WERTIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "0382ff5e-b921-4651-afe9-b5ed0e82be5a",
//                                               "code": "MICROPLAN_MO_11_06_05_08_GEDETARBO_3",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "57dc84c1-dc7f-4ef3-b234-d93531572aa3",
//                                                       "code": "MICROPLAN_MO_11_06_05_08_01_HELOMEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "8e529bc8-c2bd-4684-a5b5-131e99c98ce4",
//                                               "code": "MICROPLAN_MO_11_06_05_07_GEDETARBO_2",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "cdb950b4-387b-460d-b16b-f53c444a5963",
//                                                       "code": "MICROPLAN_MO_11_06_05_07_01_NEPLUWIEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "acfcb3dd-443c-4b40-8fdd-c264caad59d1",
//                                               "code": "MICROPLAN_MO_11_06_05_06_GEDETARBO_1",
//                                               "boundaryType": "LOCALITY",
//                                               "children": []
//                                           },
//                                           {
//                                               "id": "73bd5521-0c79-4e40-ad0c-d612f652ab3f",
//                                               "code": "MICROPLAN_MO_11_06_05_05_GBOLOBO_BESSIKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "300d38e5-29e5-4046-a327-b391e0f46480",
//                                                       "code": "MICROPLAN_MO_11_06_05_05_06_GBOLOBO_GEEWLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "44bfaead-3dcb-4f6a-adec-bd7d9abea3b2",
//                                                       "code": "MICROPLAN_MO_11_06_05_05_05_FODOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "68b26ac1-b4e1-4df7-8406-7894fe1b4dcb",
//                                                       "code": "MICROPLAN_MO_11_06_05_05_04_GBOLOBO_TAMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "297c1e74-6bd6-408d-817a-be97de2229b5",
//                                                       "code": "MICROPLAN_MO_11_06_05_05_03_GBOLOBO_BESSIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c0e699c1-e9eb-4ec1-a351-0a7839b7f53b",
//                                                       "code": "MICROPLAN_MO_11_06_05_05_02_GBOLOBO_TUNUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f6c7cb1a-832c-4ff4-bea6-d06396eda621",
//                                                       "code": "MICROPLAN_MO_11_06_05_05_01_GBOLOBO_KAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "8ab65867-a3d1-4e62-9d82-7d43b13072f1",
//                                               "code": "MICROPLAN_MO_11_06_05_04_PLEEBO_ZONE_11A",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a2426796-a525-4a89-b389-0aec315a542d",
//                                                       "code": "MICROPLAN_MO_11_06_05_04_06_PLEEBO_ZONE_11C",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c0df1f5f-ae85-4882-b926-6b61877a13fa",
//                                                       "code": "MICROPLAN_MO_11_06_05_04_05_PLEEBO_ZONE_11B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "88e0a298-c1ac-4cab-a750-c6406302443d",
//                                                       "code": "MICROPLAN_MO_11_06_05_04_04_PLEEBO_ZONE_11A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3a6f13a3-86bb-4b46-9813-b0ce9f433779",
//                                                       "code": "MICROPLAN_MO_11_06_05_04_03_PLEEBO_ZONE_10C",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9c08ad9a-0477-4286-81a4-e6d364c634c5",
//                                                       "code": "MICROPLAN_MO_11_06_05_04_02_PLEEBO_ZONE_10B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "13771076-b81e-4aad-aa2d-82a907e265cc",
//                                                       "code": "MICROPLAN_MO_11_06_05_04_01_PLEEBO_ZONE_10A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "8954579f-4398-463f-aa03-6b46da301aee",
//                                               "code": "MICROPLAN_MO_11_06_05_03_PLEEBO_ZONE_7A",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "dd22cf62-69f0-4912-bc5d-7c5e41cbffca",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_07_PLEEBO_ZONE_9",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5503d8bc-5dfa-454c-9d1e-68006c80b677",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_06_PLEEBO_ZONE_8",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4ab23417-ac24-49f0-bbda-748c28143f01",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_05_PLEEBO_ZONE_7C",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f7d50390-c8a5-4418-ac37-ed3d16461c17",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_04_PLEEBO_ZONE_7B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9465cd26-21e9-42ff-a934-c33de09414f9",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_03_PLEEBO_ZONE_7A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4050c102-0589-4d02-8132-ec0bd9c84338",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_02_PLEEBO_ZONE_6B_CRC_CAMP_5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b7b069f9-18b6-4568-9c7b-f504c2a9d2a0",
//                                                       "code": "MICROPLAN_MO_11_06_05_03_01_PLEEBO_ZONE_6A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "df9e6622-0721-400a-9016-6b0293c7a945",
//                                               "code": "MICROPLAN_MO_11_06_05_02_PLEEBO_ZONE_3A",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0066c05d-4157-4712-8dbf-90b0d5038149",
//                                                       "code": "MICROPLAN_MO_11_06_05_02_05_PLEEBO_ZONE_4C",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f3ce4479-451c-4015-9f12-6127980c2b4d",
//                                                       "code": "MICROPLAN_MO_11_06_05_02_04_PLEEBO_ZONE_4B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0bb7cbe5-9866-48f8-a78a-fd0a65c550b6",
//                                                       "code": "MICROPLAN_MO_11_06_05_02_03_PLEEBO_ZONE_4A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "926bcc9c-48ef-4a29-b620-d1612a199aa4",
//                                                       "code": "MICROPLAN_MO_11_06_05_02_02_PLEEBO_ZONE_3B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "25fd6e65-4728-4525-b6ce-9d27ab9a563e",
//                                                       "code": "MICROPLAN_MO_11_06_05_02_01_PLEEBO_ZONE_3A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "e97d48d5-43a5-496b-84f5-740e4b937670",
//                                               "code": "MICROPLAN_MO_11_06_05_01_PLEEBO_ZONE_1A",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4e1f5cbf-24b8-45ea-8c60-ffeb0f46e772",
//                                                       "code": "MICROPLAN_MO_11_06_05_01_05_PLEEBO_ZONE_5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1d0ccdca-fe74-42d9-bfc3-f890673c96fa",
//                                                       "code": "MICROPLAN_MO_11_06_05_01_04_PLEEBO_ZONE_2B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9760c3a8-8d4b-4b60-afb1-10fb1759c8e5",
//                                                       "code": "MICROPLAN_MO_11_06_05_01_03_PLEEBO_ZONE_2A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1e3e4565-515b-4f1b-8b1b-74fbbd4d499e",
//                                                       "code": "MICROPLAN_MO_11_06_05_01_02_PLEEBO_ZONE_1B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "064eeec3-3be1-42f5-9fb4-323226b80dd9",
//                                                       "code": "MICROPLAN_MO_11_06_05_01_01_PLEEBO_ZONE_1A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "e7efd679-264f-452d-9529-e92e3d9efc6d",
//                                       "code": "MICROPLAN_MO_11_06_04_GBLOKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "fa172cdf-dca0-4e1a-a73c-011300911b83",
//                                               "code": "MICROPLAN_MO_11_06_04_01_GBLOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "3c331591-8f28-405a-af68-35c92e78ad5a",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_09_DEBLEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e631b01c-24e6-4595-994b-286165d534f2",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_08_SADEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "591dd3e9-1310-4023-a5f1-8231ee6f1905",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_07_NIKPACHELU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "74b39b81-0f76-4751-b243-c968ccaf38a3",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_06_SEDEKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c15dfe34-5be4-4b58-a295-5058be8768ff",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_05_GBAKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "78164514-7328-42b9-a67e-055e8e455cd0",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_04_SOLOKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fec012b2-f56d-4aaf-94ef-eca85efcfbee",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_03_TUMBIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8fc0728b-196e-4e2e-9cf3-5afb040bcdbd",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_02_KWILOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a679b266-e808-45b4-97fc-df0278887b59",
//                                                       "code": "MICROPLAN_MO_11_06_04_01_01_GBLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "5b4ffe9d-d3cd-4414-853c-a4c4c73cd66f",
//                                       "code": "MICROPLAN_MO_11_06_03_OLD_SODOKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "5f8ef1b2-e7c7-4028-891a-595f341564a1",
//                                               "code": "MICROPLAN_MO_11_06_03_01_OLD_SODOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "1da56af0-82a3-4171-82e2-4ce3e30e696d",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_08_CAMP_10",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "064e5d83-ec66-47d6-8543-ee1e7d87f798",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_07_GOLOBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "19b1d6b6-694c-4f4a-bdd2-3d811071f6d2",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_06_WATCHOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "acff51b6-7861-450c-8661-32921de7cca8",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_05_GBEWIEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "36353385-abce-44f0-9165-86cffc997eab",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_04_MOPP_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7eed6454-65a7-40fe-a3a3-04b29e185c66",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_03_NEW_SODOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1cbef0b0-8b60-4169-9c0b-b3dcd9a4b5bb",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_02_GBOLOLU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b9d89ae0-be2b-4f68-b6f7-e70690e86558",
//                                                       "code": "MICROPLAN_MO_11_06_03_01_01_OLD_SODOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "94d10fad-240d-4cfb-bd8e-756293959d15",
//                                       "code": "MICROPLAN_MO_11_06_02_ROCKTOWN_KUNOKUDI__CLINIC_",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "4ee1e4d4-5e64-4930-961f-ed0c3107d811",
//                                               "code": "MICROPLAN_MO_11_06_02_01_RTK",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b9887229-4f7c-450d-8e03-eb1b73348b2e",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_08_TENDEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b1785480-182a-4972-892c-024ebd823ded",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_07_CAVALLA_KUNOKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f87b42d7-afab-4ead-8341-7c1bd4f12633",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_06_TUOKPEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4dad0371-c38f-4810-9b7c-70984011b0b1",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_05_JLOBOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ab5eb995-21ef-422b-8dfc-b914d7129e97",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_04_BLAGEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "76011c6d-d6d4-4075-aabd-58b5be927236",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_03_GEKOEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "55b0e784-bb6f-4ee4-9811-f3e00979b983",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_02_GENIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "92b0a01d-b53c-4495-a393-71c42c8208f0",
//                                                       "code": "MICROPLAN_MO_11_06_02_01_01_RTK",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "8a307c14-fedf-4d6a-8b4b-66334137daae",
//                                       "code": "MICROPLAN_MO_11_06_01_BARRAKEN_CLINIC__FIXED_DP_",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "e693ee9b-f4bf-4b32-8b8a-e89dde2aae5f",
//                                               "code": "MICROPLAN_MO_11_06_01_01_BARRAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "20d9f02d-b900-44ec-b329-25eb19682f5d",
//                                                       "code": "MICROPLAN_MO_11_06_01_01_05_NEW_GBAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "08b8149a-6178-4ecb-b98e-883cb9fa30ca",
//                                                       "code": "MICROPLAN_MO_11_06_01_01_04_REFUGEE_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "226fb6d5-c00e-4c45-a32d-a095d7991669",
//                                                       "code": "MICROPLAN_MO_11_06_01_01_03_WEAH_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3db7c171-656e-4839-a77b-86d3dacbf031",
//                                                       "code": "MICROPLAN_MO_11_06_01_01_02_OLD_LADY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9ec2f545-23af-4825-9b2c-f35bdd0f0124",
//                                                       "code": "MICROPLAN_MO_11_06_01_01_01_BARRAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "f00eebf5-9271-4770-97ef-d7ea5b17a3a3",
//                               "code": "MICROPLAN_MO_11_05_KALUWAY__2",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "db899ea0-5ca8-480b-a619-bfa2a74bc6e0",
//                                       "code": "MICROPLAN_MO_11_05_03_YEDIAKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "5c0aacd5-d2c3-4875-90af-65281d0b3077",
//                                               "code": "MICROPLAN_MO_11_05_03_01_YEDIAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ca767d2b-bac2-485f-a89c-824da37bf418",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_11_YORKEN1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4f0597a9-c818-4674-894d-56fbb4cb9a46",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_10_YORKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6bdbe620-9b0e-4463-b1c0-17be76db5b8f",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_09_YOBLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "eb1d2ade-f3d1-4dc9-926d-3f52a7e2fd49",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_08_JOHNSONVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3670029a-b283-43e5-bb07-36d28840c96b",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_07_YEDEROBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "affca499-e66b-41de-8f21-874ce1d9c976",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_06_NYEONWISIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "eeea43b8-d135-47b1-bc60-28565dd89265",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_05_GBON",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "da753c12-b626-4793-85f1-18208e9170cc",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_04_GBISO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "08aca98a-642e-42ea-ba48-d85496820ae0",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_03_GBAWILY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d3870fcd-b97d-413e-a377-90f8c05f390b",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_02_WELEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "65eb20cb-4cff-4787-b156-935f2a3d36c1",
//                                                       "code": "MICROPLAN_MO_11_05_03_01_01_YEDIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "86ddc672-8317-4e51-a442-a3c9934fb74e",
//                                       "code": "MICROPLAN_MO_11_05_02_MANOLU_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "2a59fd4a-689b-461c-a522-bfe5b01ac4c0",
//                                               "code": "MICROPLAN_MO_11_05_02_01_MANOLU_BIG_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9b8a613f-b9d8-4712-9b8c-97e61b76a684",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_11_SUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c1d16a16-6508-42a7-8343-53773323b8fb",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_10_KPANIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a098d9bb-5516-48d9-8818-ef4d2caaa48a",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_09_BABORKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ec343ac4-4a90-42b0-9122-35f347451421",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_08_TARWONKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ccdf5772-f883-440c-9ba1-fa6b8400e595",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_07_NYENOWROKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0cbfda13-1c84-464e-915e-cbe9a3269267",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_06_GBAWANKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8f322e2a-e056-4f9f-8308-a8ad8ea17c85",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_05_POTUSO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "243a710d-686c-40ed-9e8c-1524ef03cd62",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_04_DOKLIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1813243e-e781-4af5-9e48-eb5635bed41e",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_03_NEWAKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dff47d98-5cb1-4492-a8ad-1939f0070ba3",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_02_MANOLU_BIG_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8f39b73c-a116-42fd-b7d4-adc7deea1282",
//                                                       "code": "MICROPLAN_MO_11_05_02_01_01_MANOLU_MISSION_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "b2773cb1-36f4-4c83-a57b-b37883861257",
//                                       "code": "MICROPLAN_MO_11_05_01_BONIKEN",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "5eab53a7-00c7-4a72-a06d-85bd4f015627",
//                                               "code": "MICROPLAN_MO_11_05_01_01_BONIKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ada2eab2-8f99-4bfe-9893-afbc535882b7",
//                                                       "code": "MICROPLAN_MO_11_05_01_01_06_DOLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ed049a30-3664-401f-adba-936d2bf2ffb6",
//                                                       "code": "MICROPLAN_MO_11_05_01_01_05_WLOWIEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "564b4012-2c2a-4aae-8d50-f24167815d93",
//                                                       "code": "MICROPLAN_MO_11_05_01_01_04_GIANT_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5db488ed-7356-4cd9-85d5-79900bb3d2de",
//                                                       "code": "MICROPLAN_MO_11_05_01_01_03_HENONGBE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f4d7db2d-a8d3-42f8-accc-01cfe5dd2f37",
//                                                       "code": "MICROPLAN_MO_11_05_01_01_02_TUGBAKEN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "feacaf2d-0e9d-41ee-a6c2-570d8c2ea35a",
//                                                       "code": "MICROPLAN_MO_11_05_01_01_01_BONIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "504364a5-e48b-49be-969f-5f9d36fb883b",
//                               "code": "MICROPLAN_MO_11_04_KALUWAY__1",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "30bbba3d-7822-4822-ac5e-bb944e17457e",
//                                       "code": "MICROPLAN_MO_11_04_02_POUGBAKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "2db12400-7045-4e8d-88dd-43130f65ec83",
//                                               "code": "MICROPLAN_MO_11_04_02_01_POUGBAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "38cca85b-4f1e-43d9-b91a-9c3289f5048b",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_07_TYETEWASO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f87eaf2f-8336-49a7-8666-0d2d5ce7c162",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_06_POMUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "11eb5433-81a0-4e3a-b3be-388f3ade2ae6",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_05_WUIUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8c4aa548-1447-43fc-b1ef-f1cde73137e5",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_04_ANDERSON_FARM",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3d49cdb5-aa93-4415-9ea8-6b4cd0db64ab",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_03_GBAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "706adcec-92c5-4b98-b56d-69b6dc0a6597",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_02_TOCHOSO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "71e2fe10-ead5-4254-873f-c8686082d7a6",
//                                                       "code": "MICROPLAN_MO_11_04_02_01_01_POUGBAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "3adb1bf5-87b4-46ab-928c-f5bfb1e70982",
//                                       "code": "MICROPLAN_MO_11_04_01_EDITH_H__WALLACE_HEALTH_CENTER",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "454166ed-45d7-4a2d-82ae-2b130a0e8155",
//                                               "code": "MICROPLAN_MO_11_04_01_01_KARLOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8268a6ea-5432-4fb4-8799-f992e152a56d",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_21_GEDEBO_TUPELUSO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9a02caf6-e6b4-4534-9a32-8aec0d811771",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_20_GEDEBO_HEWEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f86310ae-46a5-4f76-b695-900ababc4640",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_19_GEDEBO_KLISO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a389a178-15c1-46a9-8836-d6eecca55dfc",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_18_GEDOBO_TENSOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0f9d792c-00a4-4891-bbec-cdef0ca08c3b",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_17_GEDOBO_KARBLAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9d74165a-d7c4-4820-a757-b67e037e6825",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_16_GEDEBO_BIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "01d55a96-5057-4602-9178-918e24d5047d",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_15_GEDEBO_JLELOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "80d15966-57de-4d5f-8458-84f35fe88c21",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_14_DORROBO_KLILIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1d07f422-28d2-4043-bf5d-fa8b7fbb9ead",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_13_DORROBO_WLUPLUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7a23b953-adbd-48fd-800f-324ccdddd2a4",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_12_DORROBO_SAYLILAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2898fa18-2229-4afc-8cf7-d2da95c17327",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_11_DORROBO_KONUSO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "00625e81-5070-45c5-a5f6-11e44ac91d58",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_10_DORROBO_GBAWAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3548372d-1e7e-4db9-833c-779045580fb7",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_09_DORROBO_GBALAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8b3f560c-bf1e-4acc-87ae-f83290c80f18",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_08_GEDEBO_DIAGBLILAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "89aedd9b-5521-4f38-b391-789e908adac1",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_07_GEDEBO_WULUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "28995c18-2ce3-45ca-925d-b9082b3e3364",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_06_GEDEBO_WARTEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f990f759-899a-408e-a005-a9f40ee38686",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_05_KARLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "803bc9f3-1a70-4b1c-868b-72dc51a41f7a",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_04_GIO_VALLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2074a62c-3e2d-4356-9cb2-5497cd70a916",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_03_GEDERO_SUASU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ee72f242-af52-4968-9182-d322d8e666c2",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_02_GEDERO_KONUSO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "71be2cd4-d370-49b7-82f2-99ecb77264d5",
//                                                       "code": "MICROPLAN_MO_11_04_01_01_01_GEAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "fec8840e-f785-48cf-8c57-e4dc1c03403e",
//                               "code": "MICROPLAN_MO_11_03_HARPER",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "1597eb30-019f-4a6c-ac46-e8bee5458897",
//                                       "code": "MICROPLAN_MO_11_03_06_ROCK_TOWN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "793f78eb-0275-42c9-abc0-4bff72175a3b",
//                                               "code": "MICROPLAN_MO_11_03_06_01_ROCK_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "bef9b077-e2f6-4402-ad42-b89800471f0d",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_07_LITTLE_WLEBO_NEW_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4f93f7c2-8781-43b4-b2c9-ef829fabd44a",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_06_LITTLE_WLEBO_OLD_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "06430cae-1964-4364-af44-3bffef01c641",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_05_LITTLE_WELEBO_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "60962bdc-b10e-4b46-bd81-6b2ee3efeab8",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_04_NMAKLEWIEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fb219099-4d8a-4538-8bc9-38aaab51bc95",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_03_MIDDLE_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2b944ec1-4410-4e7d-abfd-34ca69211022",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_02_GYIGBIDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "747f373b-e53e-446a-9816-093596ff77bf",
//                                                       "code": "MICROPLAN_MO_11_03_06_01_01_ROCK_TOWN_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "1e1f95b5-c8e2-4f8e-981b-45f5873ba5f5",
//                                       "code": "MICROPLAN_MO_11_03_05_JJ_DOSSEN_HOSPITAL",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "37d482eb-34a4-4838-a84a-f26f00f106b1",
//                                               "code": "MICROPLAN_MO_11_03_05_01_JJ_DOSSEN_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "413f59c4-30bd-4b1d-9bb2-d58eb22f57c7",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_29_HARD_WOOD",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a28c2619-2490-419f-ad1a-97104eab0f1a",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_28_GIABO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6414e3b4-5e2c-417f-abe4-0ab89aec7666",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_27_MILLIONAIRE_QUARTER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1f4f4c98-5517-477f-9e3d-27a814ecd060",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_26_BARROBO_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "54c87026-6207-4a04-8937-8d89becd30df",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_25_NEW_KRU_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "473549af-5be8-4600-991e-537663371fc3",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_24_PEACE_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8be9b1a4-9d4f-4aa3-8021-8583fc7d1429",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_23_PULUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "105809c7-94e2-46f6-abf0-f0f983e4af0c",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_22_BIGTOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ceeb961c-a086-40b7-8e91-73bdaa26baa7",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_21_WAA_HODO_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3c3c71fa-f7c0-4701-88e0-62285a2bafe0",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_20_WULUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e0d08316-bad6-4fcd-a2e2-202159a28a0e",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_19_CENTRAL_HOFFMAN_STATION",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ed22270f-60bd-45ee-9704-3d93ada7c981",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_18_BISHOP_HILLS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b986b5cb-af4c-4772-8994-c44a9766b01d",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_17_HENCE_STREET",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "02b0f853-38c7-40e9-81cc-7c6dedf26d1b",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_16_BONGAR_HILLS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3f5bedc9-65b2-4c72-bf56-59660c82b334",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_15_AIRFIELD",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ae5304df-e389-4045-a98e-06b41205a151",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_14_EASY_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3d1b9a5b-e572-459a-8571-1062427f6045",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_13_TU_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1b51eb52-ff3a-4433-8b0c-7c936f3c5769",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_12_PHILADEPHIA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "28352027-3ce4-4839-a0b1-94e2f2a6d1a5",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_11_KPAFLOVILLE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f7738bce-971c-48ae-9c99-d0f759a1726a",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_10_NEW_HARPER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ea7b45d0-7f13-4158-88b9-84bfef130fdd",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_09_STADIUM_ROAD",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6a925ac6-751d-41fb-8b13-1dbe8d55dfab",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_08_CENTRAL_HARPER",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "182c09c1-b72f-4c1e-99dd-624db601c414",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_07_OLD_KRU_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b394c699-2e90-4ded-b457-99ac460946dc",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_06_BASSA_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "da7944ae-45fa-4072-8dfa-be5d29a6bc15",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_05_MARSH_STREET",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "65dfa16b-21f6-453e-88ad-4b1165a34178",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_04_NEGANGBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a87dd8ef-3814-4fa1-9fef-4651f52b3826",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_03_MIDDLE_CESS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7e3bdb17-7c23-4f71-a16e-bbd27351e479",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_02_LAKE_SHEPERD",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4ebb4a97-15c4-4c5d-842f-b01e0f7f51cf",
//                                                       "code": "MICROPLAN_MO_11_03_05_01_01_JJ_DOSSEN_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "cc7eb844-2007-48bd-978b-51ad6255a244",
//                                       "code": "MICROPLAN_MO_11_03_04_PULLAH_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "3dcde9b4-eed8-4458-9f84-8dd033b6ee62",
//                                               "code": "MICROPLAN_MO_11_03_04_01_PULLAH_COMMUNITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e98a720a-9988-48b5-9f0c-cc5894a02225",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_12_SPRING_HILL",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "402f6e09-eabb-45bf-89e8-67ea3ef3b82c",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_11_NEW_HALF_GRAWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a9377c87-a484-4e62-83ec-ab9a0c888720",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_10_FEGURSON",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "10a68b8b-9b95-46db-a1f5-3560229ce993",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_09_KIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6401a9e3-2577-485c-9c68-bd94a0602b2d",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_08_NABLEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2463687d-2576-41de-a8e2-97a33a5906ed",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_07_TICHARBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "83ebcda5-22ae-401d-a939-bfcec8bb591f",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_06_MLEWIEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b44ffdd5-a4b9-47e5-80d8-31f1ab111ba7",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_05_PULLAH_COMMUNITY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1d98315e-53db-4dab-acba-eaeede823571",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_04_WLUPLOWEIN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "77eae21a-7b17-4681-b1a7-7f1c538c9d6a",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_03_OLD_HALF_GRAWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "224b0095-d7a1-4743-8a9b-f9f7e105d450",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_02_KING_S_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c058b663-2833-4755-8bf7-284698105837",
//                                                       "code": "MICROPLAN_MO_11_03_04_01_01_WHOLE_GRAWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "24c83aa3-60ff-4784-a970-7142020858d7",
//                                       "code": "MICROPLAN_MO_11_03_03_CAVALLA_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f4b2b195-9c1e-4296-ab86-b9a7e8934d40",
//                                               "code": "MICROPLAN_MO_11_03_03_01_CAVALLA_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7b5c21e4-4fbd-459d-9006-8bf9b3844cd5",
//                                                       "code": "MICROPLAN_MO_11_03_03_01_05_KABLAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2f6c1e44-79c2-41f0-ba7f-8fcada2deac7",
//                                                       "code": "MICROPLAN_MO_11_03_03_01_04_KAAKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "594870f9-99b4-4166-8d0e-88ee290687dc",
//                                                       "code": "MICROPLAN_MO_11_03_03_01_03_SEDEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ad2c33a4-9e78-4ebd-b3bd-a48b937b44cb",
//                                                       "code": "MICROPLAN_MO_11_03_03_01_02_WORTEKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ff7acb5b-fb3a-403f-bf02-ab4e974ed5be",
//                                                       "code": "MICROPLAN_MO_11_03_03_01_01_CAVALLA_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f14f8442-458d-4f36-9ac6-52888faed60e",
//                                       "code": "MICROPLAN_MO_11_03_02_YOOKUDI_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "ad71d05e-7dc8-4f39-b75f-a0d606b7aaab",
//                                               "code": "MICROPLAN_MO_11_03_02_01_YOOKUDI",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "291e0bcb-315e-4fbd-9cfa-652927dda4ee",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_10_TANGBALEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c0aa64b0-b809-4150-a1e0-fd3ae88a2474",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_09_JEDEBIAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "91ae7b18-b347-4155-aa01-b4a0990d4b35",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_08_WOLIPLKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "dc7925d4-04b6-412a-b733-77e486e6d409",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_07_DUOKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a779b0b9-4f87-4ba5-9fbe-86e14500baee",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_06_POOSIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "40c919e0-7121-415f-a869-45d9522260d0",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_05_KUDEKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b602c590-501e-4ca7-8f4b-d38c2e476911",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_04_YOOPIDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "69f85caa-891b-4b4c-a4c6-11bf76d9a182",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_03_LIBSUCO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "209f6613-afae-4089-8e2a-a2d533793471",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_02_PEDEBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cb42d564-4b60-46d4-9bef-e3c00d45877c",
//                                                       "code": "MICROPLAN_MO_11_03_02_01_01_YOOKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "9e0d25c1-84c7-4268-8cf3-24e822953ac3",
//                                       "code": "MICROPLAN_MO_11_03_01_FISH_TOWN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "feca4540-a78d-43d2-a25d-537198f42478",
//                                               "code": "MICROPLAN_MO_11_03_01_01_FISH_TOWN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0351374e-7fa8-4706-987b-d680d23fb8de",
//                                                       "code": "MICROPLAN_MO_11_03_01_01_05_TUPAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "201d60c9-b8f0-49b3-8ba8-c34b113fc143",
//                                                       "code": "MICROPLAN_MO_11_03_01_01_04_BOHLUYEH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ce9a37a2-54d4-41e3-9cad-8ecb954f4b4f",
//                                                       "code": "MICROPLAN_MO_11_03_01_01_03_PONWIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "14cb9493-7c61-44c4-a9e6-101566d100c1",
//                                                       "code": "MICROPLAN_MO_11_03_01_01_02_GBOKUDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "61ad1d34-df9e-4f7b-adac-19dd5522087c",
//                                                       "code": "MICROPLAN_MO_11_03_01_01_01_FISH_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "2d4a5b49-3141-48ca-b4da-cfbe3285c055",
//                               "code": "MICROPLAN_MO_11_02_BARROBO_WHOJAH",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "d1f8b177-45ed-4bf6-bc52-be9127cb0a7a",
//                                       "code": "MICROPLAN_MO_11_02_03_MEWAKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f1d8f964-3991-4938-aa38-dc9eba19178c",
//                                               "code": "MICROPLAN_MO_11_02_03_01_NEWAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "3a3b9b47-833d-4819-9c1b-b8dfc22f4256",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_07_SEATOR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "deca62e4-5c3a-4c77-a4d1-08a60fe77fa1",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_06_SAWTOKEN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3d722336-4c93-446c-b7d0-eec30c6674e3",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_05_SARGLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aabc7ea6-cb68-4249-be99-0cb55af2d281",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_04_JARGLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "80077a89-aa7e-4e39-9276-bd6c86c76839",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_03_SAWTOKEN_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2a5e2e3f-e202-48ff-9770-64dd9c049d78",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_02_SOLOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "609aa38a-23a8-4247-8bc5-c1232dfb4a23",
//                                                       "code": "MICROPLAN_MO_11_02_03_01_01_NEWAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "aa101843-de10-4f35-a984-41241d67c8db",
//                                       "code": "MICROPLAN_MO_11_02_02_JULUKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "65d691e0-20ac-48ac-9fc8-94167fd3d301",
//                                               "code": "MICROPLAN_MO_11_02_02_01_JULUKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "bf4d815e-494f-4cd8-a206-c3d38c353db3",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_12_SMALL_JAYE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "824e3c45-89b1-47b5-af98-a45aaed0cc86",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_11_BESSIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "79988a74-8dbc-43a8-9a41-7b3dbd88b530",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_10_FULA_CAMP",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0dc9ed58-ac08-473c-a70f-c15efb81ec3d",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_09_TAPOLINE_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "63895055-f6ca-41b3-b660-84b77616da50",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_08_TUGBAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "34a56cec-08f8-4b66-a905-3bd82d42576b",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_07_KPLOWAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "449dfa34-c00e-4c46-a47a-d80d681f8cca",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_06_GORTIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cbf839ba-4dfc-4b8f-a56c-edea81fca22b",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_05_GORTUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4daad467-51c6-4df4-90f2-272d0339c6c0",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_04_MARTUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "844e486d-c177-4fd7-9ffd-e33232c7deb2",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_03_JULUKEN_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "faf30355-c2f2-44db-bcad-3cbae33c72d1",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_02_DWEJAH",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b5a0c9b0-1cb8-4bf5-9b62-530833ed84ea",
//                                                       "code": "MICROPLAN_MO_11_02_02_01_01_JULUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f6e648f1-385c-47ca-a308-58bd78358118",
//                                       "code": "MICROPLAN_MO_11_02_01_GLOFAKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b339e4b9-b085-4721-90ef-fb62f326b657",
//                                               "code": "MICROPLAN_MO_11_02_01_01_GLOFAKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c9a4ca5e-9e08-4dbc-8b57-8c45c52384f3",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_07_GWELEKPOTOWIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4809c199-16d1-4c26-9a76-74552d293fac",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_06_GESSAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a669b119-9ff3-41e9-aad1-2d8f64021531",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_05_GBAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "497d5fdc-7692-4a35-8667-233a3e2def5f",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_04_SAWKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6aa573ec-cc8f-4e42-96a1-85c0241748e5",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_03_CHILIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a5a20cf5-2fcf-4e6e-8d8a-7d05bdea3fa6",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_02_DUGBOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1a4ea330-efc5-4758-acfc-9b105599b72a",
//                                                       "code": "MICROPLAN_MO_11_02_01_01_01_GLOFAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "b4210811-27f8-4b6d-87b3-b0fe699c6a45",
//                               "code": "MICROPLAN_MO_11_01_BARROBO_FARJAH",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "5d268b1e-9442-4c4a-b625-2e71fb03222d",
//                                       "code": "MICROPLAN_MO_11_01_02_FELOKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "095d8635-17f0-4731-be52-b0642a3ce642",
//                                               "code": "MICROPLAN_MO_11_01_02_01_FELOKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "90d66871-6194-4fc9-9c7e-7f4a2c2d4ff4",
//                                                       "code": "MICROPLAN_MO_11_01_02_01_06_KPANNISO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6050cf21-1d90-41b8-af9c-3495ba0ddb85",
//                                                       "code": "MICROPLAN_MO_11_01_02_01_05_GBARKLIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "99bd258f-2b28-4a80-99fa-342c285a6465",
//                                                       "code": "MICROPLAN_MO_11_01_02_01_04_BIG_JAYE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b2b476b4-6700-40fc-8393-b5e9e55ca075",
//                                                       "code": "MICROPLAN_MO_11_01_02_01_03_FELOKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "79f6604d-6138-472f-8be3-bf6732105143",
//                                                       "code": "MICROPLAN_MO_11_01_02_01_02_BULTIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef315cb6-d6fa-4fd7-b760-d9187311951e",
//                                                       "code": "MICROPLAN_MO_11_01_02_01_01_FISHTOWN_HIGHWAY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "55bd15dc-e4d6-497d-b6de-4372439fa649",
//                                       "code": "MICROPLAN_MO_11_01_01_GBARWILIKEN_CLINIC",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "e2948fc0-ad1e-41eb-9ce6-78473f7d2e4e",
//                                               "code": "MICROPLAN_MO_11_01_01_01_GBARWILIKEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b6dd678b-e554-47d7-8b4f-6d9193e58802",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_08_TENKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3e8c9bf9-d16c-4e00-8d2a-ce739dc0a3cc",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_07_KARDIO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5f43aaeb-75ad-473f-9562-8f400365103c",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_06_GBARWILIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "98f49d68-08a8-4e3e-b3cb-5cdf34ced78e",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_05_GUTUKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "039968b9-0a79-4d9e-aeb5-1baa13dcfabf",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_04_ROCK_TOWN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cbcf0cda-6840-4d6b-8cbf-01819d41e541",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_03_TEAKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aa75bee7-38a2-479f-8aa6-9964814c68ee",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_02_MARFLIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "92aa0d14-9f86-4cf5-a5a9-c0932f8a9d4f",
//                                                       "code": "MICROPLAN_MO_11_01_01_01_01_GWISSIKEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "4ad51d4f-db4e-410a-99d5-26c19ca85ae9",
//                       "code": "MICROPLAN_MO_10_MAPUTO_CITY",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "22a05beb-aed0-428e-80f7-591a08a093d4",
//                               "code": "MICROPLAN_MO_10_02_KAMAXAQUENE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "9159546a-33cc-4280-a1d2-23fde4f94d47",
//                                       "code": "MICROPLAN_MO_10_02_01_KAMAXAQUENEA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a806c7eb-b375-4722-8dee-2573756c4af8",
//                                               "code": "MICROPLAN_MO_10_02_01_01_KAMAXAQUENE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0fcc1e23-f2fc-4be7-aeef-37d9d09bb900",
//                                                       "code": "MICROPLAN_MO_10_02_01_01_04_CHIRINGU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "91cf76ff-6f83-41fc-82f6-56e1d6f22ceb",
//                                                       "code": "MICROPLAN_MO_10_02_01_01_03_CHINMARI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f06254b0-69dd-49fe-a3ec-4899276c00be",
//                                                       "code": "MICROPLAN_MO_10_02_01_01_02_MAZAMBIQUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "86ed6a94-4147-4bf2-a43a-80ff4c2625f9",
//                                                       "code": "MICROPLAN_MO_10_02_01_01_01_NHAMAZANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "41e2818f-a82a-4c73-bb26-698648d8ba5c",
//                               "code": "MICROPLAN_MO_10_01_KAMPFUMU",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "478b1b8d-7a66-44db-941b-7b591ac8223c",
//                                       "code": "MICROPLAN_MO_10_01_03_KAMPFUMUU",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "28e74c78-a733-44d8-b1d9-9568d457aca8",
//                                               "code": "MICROPLAN_MO_10_01_03_01_KAMPFUMU_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7540b419-0d01-4668-bb9d-af3316774458",
//                                                       "code": "MICROPLAN_MO_10_01_03_01_02_CHIMARIR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "555722ad-a735-4e99-b404-fdd64f370ce1",
//                                                       "code": "MICROPLAN_MO_10_01_03_01_01_MASSAMBI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "eef14902-6a74-4819-b934-56b0e073d2a7",
//                                       "code": "MICROPLAN_MO_10_01_02_KACHAMANCULOO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "6723c90d-3c32-4e72-8e74-ff50ddac493a",
//                                               "code": "MICROPLAN_MO_10_01_02_01_KACHAMANCULO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4cd40b2c-b825-4167-97c8-8e07b0e46ca8",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_12_CHIMAZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "39e4679e-a471-4cfe-a9e8-d2d5caa5195e",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_11_CHIMBUNDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4fa43a25-b4ae-40d6-bbca-c08071598b29",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_10_MAPUTO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "96ddf0cc-47c6-4730-9b33-1f779410ce61",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_09_CHIUUREE_4",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "095924e6-4917-428f-a399-45a076adf3de",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_08_CHIUUREE_3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ca482d87-754d-4b3b-a3a6-67d3b83c33ab",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_07_CHIUUREE_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc4d6694-3909-417b-b012-5b90c76bf961",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_06_CHIUUREE_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7c35c5db-4ea5-4b67-9858-f0e6d6137a89",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_05_CHIUUREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7c2ca0e6-0727-46c3-9fb9-b6b60cb95c7f",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_04_CHISSANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8ca1c59a-9fc5-4c70-b081-6fd5868e119f",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_03_NHAMATANDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c66d9967-9b25-49dd-a082-e4dab97b6fda",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_02_MAQUIAVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "00a7fcbf-d6c2-4bfa-89b6-d8e427e0f34b",
//                                                       "code": "MICROPLAN_MO_10_01_02_01_01_CHICUANA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "9c7f109b-c9af-44c3-be1f-320b3dac6a85",
//                                       "code": "MICROPLAN_MO_10_01_01_KAMAXAQUENEB",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f53c73b7-9a19-486b-a633-6a55f8cac9c3",
//                                               "code": "MICROPLAN_MO_10_01_01_01_KAMAXAQUENEB_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ebe77ec1-a16c-463e-a5f1-627f4f686133",
//                                                       "code": "MICROPLAN_MO_10_01_01_01_04_CHONWANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bc32a2e5-bcf3-4412-924c-09bafd0776c9",
//                                                       "code": "MICROPLAN_MO_10_01_01_01_03_NHAMATCHUCO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b2faaa20-f360-4a86-859b-79af641c8ddf",
//                                                       "code": "MICROPLAN_MO_10_01_01_01_02_MAFALALA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "09758f59-2e8d-42d8-9546-e85506b2f214",
//                                                       "code": "MICROPLAN_MO_10_01_01_01_01_NHAGOLO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "8d03df7c-7d42-4679-a0b7-7d265e560448",
//                       "code": "MICROPLAN_MO_09_TEST_PROVINCE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "12ec8432-bd4b-4c55-b845-9b58747dbb0c",
//                               "code": "MICROPLAN_MO_09_02_DISTRICTTWO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "4a5e39db-c8cd-41ee-ab09-04b8be38a133",
//                                       "code": "MICROPLAN_MO_09_02_02_POST_ADMINISTRATIVEFOUR",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "40e5e27a-254b-4171-aba0-802510f0019d",
//                                               "code": "MICROPLAN_MO_09_02_02_02_LOCALITYNINE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "16e5a61d-42fb-4c4a-ab23-f691300ff4e5",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_10_VILLAGENINETY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2e97f56a-59e5-4715-8117-0bc8bf03bd3d",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_09_VILLAGENINETY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4bef6a03-e7d5-48cb-87b3-a8fd952c6fc3",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_08_VILLAGENINETY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fb4133f1-3764-4074-9449-cdd4d364e8d2",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_07_VILLAGENINETY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8e4ba473-7230-47f4-bed0-fac65bb31827",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_06_VILLAGENINETY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c6dc7429-d3b9-447d-bc62-985274f506d9",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_05_VILLAGENINETY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5e41c0a6-a2b2-4763-aa8a-3facd411f4ae",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_04_VILLAGENINETY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2958cc8e-18b5-4471-b8e0-11083ab420ea",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_03_VILLAGENINETY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "89100843-b292-4657-9e51-afa6e9e8197b",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_02_VILLAGENINETY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "31987b7f-d8ff-435f-8ed2-aabb7b9b67bd",
//                                                       "code": "MICROPLAN_MO_09_02_02_02_01_VILLAGENINETY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "0a399a32-f38e-4d5b-91cd-65dcf0867d3f",
//                                               "code": "MICROPLAN_MO_09_02_02_01_LOCALITYEIGHT",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "93c3e779-47bc-4070-9486-6917f1be5c5d",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_10_VILLAGEEIGHTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fffa545f-13e9-4c3a-99a8-0300455e9c28",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_09_VILLAGEEIGHTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "54beea2b-3115-453f-b3cd-f1f1a9908e42",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_08_VILLAGEEIGHTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cfb5425e-e043-4176-8367-9e6f10587f1c",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_07_VILLAGEEIGHTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "35486601-7033-4a9f-842c-773dcee13ba3",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_06_VILLAGEEIGHTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8fe0463c-3bed-4101-a900-6a4254cbc964",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_05_VILLAGEEIGHTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "06cd4a1e-f560-422f-bd39-ad30f8da3638",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_04_VILLAGEEIGHTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6594b6af-672e-4858-be14-8c0c1b62e38b",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_03_VILLAGEEIGHTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1d1e32f5-1f39-45d4-9892-d8249636da56",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_02_VILLAGEEIGHTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "95f3aa51-29e6-4718-a838-265a016c5775",
//                                                       "code": "MICROPLAN_MO_09_02_02_01_01_VILLAGEEIGHTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "4fcdc4cc-c29c-460f-8aca-bc936561e0e2",
//                                       "code": "MICROPLAN_MO_09_02_01_POST_ADMINISTRATIVETHREE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "72f3f8f0-9472-4ccf-943e-41b9f567d707",
//                                               "code": "MICROPLAN_MO_09_02_01_02_LOCALITYSEVEN",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7c53bcea-3dd3-4c12-8b11-2a0d271d6daa",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_07_VILLAGESEVENTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "afacbfd7-c2a1-43e9-b273-1586dd41b18d",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_06_VILLAGESEVENTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a327d2fb-0e1e-4e9a-836d-ac0c9c285c1f",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_05_VILLAGESEVENTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e5a95e78-e9d0-42f2-bd9d-c92ddaaf73b6",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_04_VILLAGESEVENTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7024f93c-9e7c-431b-8681-ee95dfd07bcf",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_03_VILLAGESEVENTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "52f7bdb3-e76f-4551-91c6-e943b95f1803",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_02_VILLAGESEVENTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "38e848e1-3ed3-4a5f-9914-176165f50ae5",
//                                                       "code": "MICROPLAN_MO_09_02_01_02_01_VILLAGESEVENTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "a92aac56-0baa-4d3e-8736-21f06cf74d13",
//                                               "code": "MICROPLAN_MO_09_02_01_01_LOCALITYSIX",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "43dc7533-9202-4b16-b9ce-a14d55172593",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_12_VILLAGESEVENTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1beecd3f-f0af-4f86-a1a2-e2208a7187e2",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_11_VILLAGESEVENTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3a523d20-d8bd-4a09-9d0e-4daff09c13fc",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_10_VILLAGESEVENTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "12ee328b-8f8d-4ff0-98c0-f511f022ad92",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_09_VILLAGESIXTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e6cd52fb-e998-43f3-8aa6-6ed45fe04650",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_08_VILLAGESIXTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6ceccc10-7486-4180-b8ed-c3c82b531825",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_07_VILLAGESIXTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ad783e51-e86c-49c2-90c7-90e0365311a6",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_06_VILLAGESIXTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "703ad900-7be3-4fc0-b0b8-cfb54b74327f",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_05_VILLAGESIXTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3bdc482f-2948-41aa-8284-edd6363c7717",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_04_VILLAGESIXTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b982ce2f-97d8-4dcd-9539-93241c0b25e2",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_03_VILLAGESIXTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a4cd57b3-6367-4c24-8ed6-9ecbda8653fa",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_02_VILLAGESIXTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c01123db-1773-44e0-aa67-7c9ebd5c5eb4",
//                                                       "code": "MICROPLAN_MO_09_02_01_01_01_VILLAGESIXTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "e7184798-35a4-45ea-9db6-b0a2eb945b3c",
//                               "code": "MICROPLAN_MO_09_01_DISTRICTONE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "ac7e2e51-8385-4eb3-b90c-a9c97022257e",
//                                       "code": "MICROPLAN_MO_09_01_02_POST_ADMINISTRATIVETWO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "60c7daa1-6b85-4d22-8196-7c2a4cac02dd",
//                                               "code": "MICROPLAN_MO_09_01_02_02_LOCALITYFIVE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e8b52d35-d0d0-421f-8fed-8a98efb591c8",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_12_VILLAGESIXTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3c2ac2a1-70ba-4a33-b677-27f624e6bf3d",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_11_VILLAGEFIFTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2df78e6f-7820-41e3-8e2b-440cff80352f",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_10_VILLAGEFIFTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ed10377f-e569-4b8a-ab9d-f098c81d6d34",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_09_VILLAGEFIFTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "46c9e62c-735c-4769-9e24-5b8494012aaf",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_08_VILLAGEFIFTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8aab18ec-3264-4642-9cc0-6ae20db14850",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_07_VILLAGEFIFTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7db7ac85-9201-46e9-8a10-83682d64c65c",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_06_VILLAGEFIFTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bf159125-59ad-47c5-bb4a-10f6eadc416d",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_05_VILLAGEFIFTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5c77c5ab-1320-4359-8130-243b950775e6",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_04_VILLAGEFIFTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "16b50152-7316-495b-ae6a-bbb33fa334c2",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_03_VILLAGEFIFTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "de8bf39f-399d-4374-b96b-54f24ed7b598",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_02_VILLAGEFIFTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "64c55c4a-3db2-4452-8ec2-a6ff0b58c8ec",
//                                                       "code": "MICROPLAN_MO_09_01_02_02_01_VILLAGEFORTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "30d13051-d421-49b2-9002-80356f93a152",
//                                               "code": "MICROPLAN_MO_09_01_02_01_LOCALITYFOUR",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7fa859e4-e5ba-4927-8106-73a5a11de8b3",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_12_VILLAGEFORTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ae37b33e-c523-42b3-b411-8bb2662952e9",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_11_VILLAGEFORTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "31347501-1ca9-42d5-81a0-f3951a456d5f",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_10_VILLAGEFORTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "28311b23-32eb-4657-8423-d8a593383b7c",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_09_VILLAGEFORTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a654e6ff-ed0a-4d4b-9e59-6c6c9e8121f0",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_08_VILLAGEFORTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8799d35d-78cb-488a-86a2-af6d07fe07a0",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_07_VILLAGEFORTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6c3116fd-a9be-4235-8b56-04d317bb032b",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_06_VILLAGEFORTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "be8c79ab-87d1-42a1-90d8-5bbe275f6ccb",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_05_VILLAGEFORTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c4b1a9af-be28-4da5-9300-96d2c5b00b87",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_04_VILLAGEFORTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a6490edf-b71d-43af-a119-fb578c541a70",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_03_VILLAGETHIRTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1eeec697-709a-4d37-bb39-d2c658a00da3",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_02_VILLAGETHIRTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a294fbf8-dab0-4053-87f9-bd0c6eede675",
//                                                       "code": "MICROPLAN_MO_09_01_02_01_01_VILLAGETHIRTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "1394e197-2f84-4272-b73a-1c4ed36e4e8d",
//                                       "code": "MICROPLAN_MO_09_01_01_POST_ADMINISTRATIVEONE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f2df10ac-d966-4961-81e1-c8c78499ec00",
//                                               "code": "MICROPLAN_MO_09_01_01_03_LOCALITYTHREE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5f8ee6f7-c130-44ba-af90-23ba5808ac0b",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_12_VILLAGETHIRTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "efb9200b-c165-4be3-b5d3-2d99ac5fb770",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_11_VILLAGETHIRTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8eaa4f23-3cc8-4481-8ed1-eba470556ada",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_10_VILLAGETHIRTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6afae431-6653-4b1c-8104-6c1c558bce5b",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_09_VILLAGETHIRTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba15fcfa-d886-4a77-9770-dc2668e12a96",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_08_VILLAGETHIRTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bceecb36-ba67-40b6-aade-b04cf04680c6",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_07_VILLAGETHIRTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d5ddc710-44b7-4aed-806c-e16c1b60fcba",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_06_VILLAGETHIRTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "118b174b-2a73-44df-8ea0-544f52015eea",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_05_VILLAGETWENTY_NINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "59f3da96-3b33-495b-bdda-6c370f376b58",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_04_VILLAGETWENTY_EIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "43e8186d-1f9f-40c3-8906-5fdca8a055b6",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_03_VILLAGETWENTY_SEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3f1861d8-74ef-4a05-a0ec-ed9acf64daad",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_02_VILLAGETWENTY_SIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "09b25af6-924f-4bf9-ae12-949dfb65514b",
//                                                       "code": "MICROPLAN_MO_09_01_01_03_01_VILLAGETWENTY_FIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "36b1bfc4-ec09-40bd-907a-070d056e60f9",
//                                               "code": "MICROPLAN_MO_09_01_01_02_LOCALITYTWO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5f25d555-1733-43fd-a570-3dca3c5bb69c",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_12_VILLAGETWENTY_FOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "09b2178a-c418-4593-9c79-f3f913d80668",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_11_VILLAGETWENTY_THREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e7362eaf-8c07-4fbe-b850-3cccbb1f5f0a",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_10_VILLAGETWENTY_TWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ab5b3865-cb7f-446e-904a-1768282cac41",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_09_VILLAGETWENTY_ONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7043f17f-c03c-4d7b-82f2-cd605e5f4f74",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_08_VILLAGETWENTY",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9ed92272-b86e-4d8b-8706-97e843422708",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_07_VILLAGENINETEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6e471e36-4dd2-4386-8643-3d8f5a1510db",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_06_VILLAGEEIGHTEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "be20db0d-220b-45ec-9893-0e2c1ba1706d",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_05_VILLAGESEVENTEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "61e84b1f-ae8c-4caa-bc6c-f30f3e5c737b",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_04_VILLAGESIXTEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f682134b-0ca9-42a2-bbd0-927734b6816a",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_03_VILLAGEFIFTEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6a5a530a-d945-43b2-bcd6-6818272962d1",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_02_VILLAGEFOURTEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7a24ffa9-f6f8-4c2b-9296-6061e14a867a",
//                                                       "code": "MICROPLAN_MO_09_01_01_02_01_VILLAGETHIRTEEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "2c8bbd2d-0200-49ee-a8e0-b09646e40f6d",
//                                               "code": "MICROPLAN_MO_09_01_01_01_LOCALITYONE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "fcf38512-5645-4ad9-b493-94a767806e7f",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_12_VILLAGETWELVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7ec82f68-4e25-4fd7-8892-43094a134c8e",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_11_VILLAGEELEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f7101f2a-5818-4355-846e-9457d6955fba",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_10_VILLAGETEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc6b9d42-bff0-4450-bab4-393e8dca19c1",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_09_VILLAGENINE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "87c1d61f-806f-4cf1-bc3e-ee52b397f99f",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_08_VILLAGEEIGHT",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "117f6502-6f6b-433b-bc89-c3e483424b48",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_07_VILLAGESEVEN",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c040b4ca-c3c8-48f0-8b22-c71c36bff143",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_06_VILLAGESIX",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6d9fb50e-3676-4560-a2f5-eb25d7199e45",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_05_VILLAGEFIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d6059fb8-e011-4200-a393-8cda99ecbc19",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_04_VILLAGEFOUR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f72ca2f6-def8-449d-a294-87a206dc0564",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_03_VILLAGETHREE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49a34e1f-5c44-48e6-b551-4bb4d014a21d",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_02_VILLAGETWO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f8a08d24-3833-4e8e-9991-9e92875a1c56",
//                                                       "code": "MICROPLAN_MO_09_01_01_01_01_VILLAGEONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "e1c4b5ae-9e6e-43c6-9c5b-d06f9acd809f",
//                       "code": "MICROPLAN_MO_08_TETE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "268ca774-b5cc-440f-913d-0af90bc9f21b",
//                               "code": "MICROPLAN_MO_08_12_D_A",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "f5b3ea3c-08b9-43ac-8517-3eb4bc6b8017",
//                                       "code": "MICROPLAN_MO_08_12_01_NHAMAYABWE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "9ffd1ce3-7c05-4fef-988c-efcd1ebba525",
//                                               "code": "MICROPLAN_MO_08_12_01_01_NHAMAYABWE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "864e65d3-37a8-4daa-a769-0a836773c4ca",
//                                                       "code": "MICROPLAN_MO_08_12_01_01_02_MATARARA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d33cc340-8e5b-45de-85a5-e208f7525634",
//                                                       "code": "MICROPLAN_MO_08_12_01_01_01_NHAMUCANDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "9f8fd6be-ef75-4bb9-ab4d-26c23db09b7e",
//                               "code": "MICROPLAN_MO_08_11_CHIFUNDE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "6d393a39-2495-44aa-9c2a-3db8db121151",
//                                       "code": "MICROPLAN_MO_08_11_01_CHINTHOLO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "42a9a540-4057-40ba-8247-cd98027d857d",
//                                               "code": "MICROPLAN_MO_08_11_01_01_CHINTHOLO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c4060fb2-7bc1-43af-9504-848e4693892d",
//                                                       "code": "MICROPLAN_MO_08_11_01_01_02_NHASSANGWA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "80033bde-a64c-42d9-83ce-0819ba52aebe",
//                                                       "code": "MICROPLAN_MO_08_11_01_01_01_CHAVITSA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "3f32effb-7c0e-4bc2-b762-44727f3bf347",
//                               "code": "MICROPLAN_MO_08_10_ZUMBO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "7927bd63-4d96-48f9-9da7-dca6b40888dc",
//                                       "code": "MICROPLAN_MO_08_10_01_MUCUMBURA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b6504b03-5987-4d58-8dfe-4e09a390f207",
//                                               "code": "MICROPLAN_MO_08_10_01_01_MUCUMBURA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f33b329f-f0af-4ae7-9ccd-16bcc91cf9e8",
//                                                       "code": "MICROPLAN_MO_08_10_01_01_02_NYAMPANDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "92a67a69-27fe-49b9-8fce-f63874003f7a",
//                                                       "code": "MICROPLAN_MO_08_10_01_01_01_MAVERA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "cf22b43f-9b38-47a8-ac25-2986388b14b4",
//                               "code": "MICROPLAN_MO_08_09_CHANGARA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "31f87ac9-c0d0-4cbd-b3f6-36236564d7d7",
//                                       "code": "MICROPLAN_MO_08_09_02_NDIMA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "89d2ebf3-cd5b-45f9-aac0-15ab0893d464",
//                                               "code": "MICROPLAN_MO_08_09_02_01_NDIMA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "cebe7b2d-20c8-4863-ab65-e0c01f63fd6c",
//                                                       "code": "MICROPLAN_MO_08_09_02_01_02_CHIRINDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ca657994-0ce2-433f-8bfe-4ae932d19112",
//                                                       "code": "MICROPLAN_MO_08_09_02_01_01_NHATHANDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "c8bfc32b-d0ff-445f-8aa1-34ee7f424a1a",
//                                       "code": "MICROPLAN_MO_08_09_01_LUCALA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "38ad9ae8-432d-4aa1-90cc-2c77bb7ac10a",
//                                               "code": "MICROPLAN_MO_08_09_01_01_LUCALA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "78ce41e3-f7d6-4898-a7dd-fdff2caa8bde",
//                                                       "code": "MICROPLAN_MO_08_09_01_01_02_NHAURAO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7802c9d8-5ace-4fbd-a0fd-87ba79c8f611",
//                                                       "code": "MICROPLAN_MO_08_09_01_01_01_MALENGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "4c3950c5-5597-4bd6-9095-9c01b6dc0f60",
//                               "code": "MICROPLAN_MO_08_08_MAGOE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "21d29761-5301-4741-a6cf-293a66d233f9",
//                                       "code": "MICROPLAN_MO_08_08_03_INHAMGOMA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f8d9706c-facb-41e1-b945-263ed4721c39",
//                                               "code": "MICROPLAN_MO_08_08_03_01_INHAMGOMA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ec753468-c756-41f3-a9b5-e9dd2dfd5c78",
//                                                       "code": "MICROPLAN_MO_08_08_03_01_02_MACARULA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3057111a-92e7-4790-a96b-d923d9897438",
//                                                       "code": "MICROPLAN_MO_08_08_03_01_01_MACHAMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "57b1e796-9aba-474b-8437-edb92e5ebc3a",
//                                       "code": "MICROPLAN_MO_08_08_02_CAFUMPA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "18128e1b-0a45-4562-859d-f48d8a48b4f9",
//                                               "code": "MICROPLAN_MO_08_08_02_01_CAFUMPA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "2b3b6b84-7ee2-4392-803b-14d77b2f9d8b",
//                                                       "code": "MICROPLAN_MO_08_08_02_01_02_CHIMBENGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b8e68e96-ab32-400f-bc4a-1c7efcd599ed",
//                                                       "code": "MICROPLAN_MO_08_08_02_01_01_MACHIPO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "50c751c8-b079-4b65-93b6-ef59590c58e7",
//                                       "code": "MICROPLAN_MO_08_08_01_CHARRE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "9de81ab5-af91-4cad-a662-0f9f31445ac5",
//                                               "code": "MICROPLAN_MO_08_08_01_01_CHARRE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "5d9e5231-fd5c-4722-9d7d-2dd75b82e304",
//                                                       "code": "MICROPLAN_MO_08_08_01_01_02_CHIMBUNDE_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "26ef5229-a7dc-4ae6-87c6-487f3e061ee8",
//                                                       "code": "MICROPLAN_MO_08_08_01_01_01_CHILUCA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "52297be0-4aaa-4690-b566-560c029db679",
//                               "code": "MICROPLAN_MO_08_07_CHIUTA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "be76a0ea-5ca2-4a46-b609-c49ed9fbb9fc",
//                                       "code": "MICROPLAN_MO_08_07_02_NHAMPOSSA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "7970ded6-bbfa-44f8-a27a-a28d4791926e",
//                                               "code": "MICROPLAN_MO_08_07_02_01_NHAMPOSSA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "03fb6d1e-d826-434c-bfbd-ececd3ebd596",
//                                                       "code": "MICROPLAN_MO_08_07_02_01_02_MACUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5de9c9fd-0a22-4e5c-889c-b733a533bfcd",
//                                                       "code": "MICROPLAN_MO_08_07_02_01_01_MAZANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "9ce1c73a-1efb-4854-8c99-300a77d4135d",
//                                       "code": "MICROPLAN_MO_08_07_01_KAFUNFO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "6a8b75df-e4f5-425c-a093-643fea084df9",
//                                               "code": "MICROPLAN_MO_08_07_01_01_KAFUNFO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "daa11476-7b41-4482-96fc-276ebbe8ed55",
//                                                       "code": "MICROPLAN_MO_08_07_01_01_02_MACAMBULA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "23583eec-706d-46c1-8dd0-1720492df31e",
//                                                       "code": "MICROPLAN_MO_08_07_01_01_01_NHANDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "262cdccf-b023-406a-b161-dac54ded2b59",
//                               "code": "MICROPLAN_MO_08_06_CAHORA_BASSA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "7a3af484-9969-42eb-8eb9-0426db8fc4af",
//                                       "code": "MICROPLAN_MO_08_06_03_MANDIE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d76b76a7-8d70-44f0-aec9-348c3578852d",
//                                               "code": "MICROPLAN_MO_08_06_03_01_MANDIE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "69bc55ca-c9f8-47b7-bba1-48f38fb408dd",
//                                                       "code": "MICROPLAN_MO_08_06_03_01_02_MACAPA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cb78f25d-b575-4f11-a7e4-1b86a83ce504",
//                                                       "code": "MICROPLAN_MO_08_06_03_01_01_NHAMISSENGUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "6bf7c9aa-d80f-48c9-80ac-5b5cdbad39df",
//                                       "code": "MICROPLAN_MO_08_06_02_SONGO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d0b409f6-93ee-4cd5-bfe0-600a2bfc60b1",
//                                               "code": "MICROPLAN_MO_08_06_02_01_SONGO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6b26b344-e296-488c-94a0-1894166be3a2",
//                                                       "code": "MICROPLAN_MO_08_06_02_01_02_NHAMADA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f40f76aa-23cd-4fc9-ae8c-3c1053c1508a",
//                                                       "code": "MICROPLAN_MO_08_06_02_01_01_MACOCHA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "2851330d-32b2-4b6d-8954-acefb02f6326",
//                                       "code": "MICROPLAN_MO_08_06_01_CHITIMA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "186dfbf1-b23e-49e1-96fa-0ee6df992190",
//                                               "code": "MICROPLAN_MO_08_06_01_01_CHITIMA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "11d2f110-9109-4b25-8d08-9461974187c3",
//                                                       "code": "MICROPLAN_MO_08_06_01_01_02_MACHURO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f13ecbd1-ae8b-4aaf-a788-d9cd7075f557",
//                                                       "code": "MICROPLAN_MO_08_06_01_01_01_SAMBINDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "16892495-0a18-4782-9824-08c9f35bee49",
//                               "code": "MICROPLAN_MO_08_05_TSANGANO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "d24ff695-1540-4f10-8002-43101c012ae4",
//                                       "code": "MICROPLAN_MO_08_05_02_MARARA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "907ee0c1-d11a-4631-8116-5e1d5703451b",
//                                               "code": "MICROPLAN_MO_08_05_02_01_MARARA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "91da3e27-2fe1-426c-b368-b4365431c973",
//                                                       "code": "MICROPLAN_MO_08_05_02_01_02_MACAIA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "93f5644a-c675-4a0f-8440-a7c81da60b4b",
//                                                       "code": "MICROPLAN_MO_08_05_02_01_01_MATCHIME",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "a9429cfc-cde2-4730-8d27-16d8867a135f",
//                                       "code": "MICROPLAN_MO_08_05_01_FURANCUNGO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b02ddd9f-5201-4f88-a9ed-77dbd6e96dd2",
//                                               "code": "MICROPLAN_MO_08_05_01_01_FURANCUNGO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f37d59ef-4ef1-49a1-aa4b-854cdb6732ea",
//                                                       "code": "MICROPLAN_MO_08_05_01_01_02_MUJA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b60f3bae-dd96-4ab1-aeeb-6fc7bbedec31",
//                                                       "code": "MICROPLAN_MO_08_05_01_01_01_MAROE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "aee6600b-13b2-4d95-a9ac-0dc83cdbfc0a",
//                               "code": "MICROPLAN_MO_08_04_ANG_NIA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "8bba3838-d7dc-474c-bfd1-abae5f9497f0",
//                                       "code": "MICROPLAN_MO_08_04_02_MULANGUANE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a03cfbfa-a175-4ea5-98ce-7e818f2867c3",
//                                               "code": "MICROPLAN_MO_08_04_02_01_MULANGUANE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6e97ac78-5572-42f1-8109-f9b6a3e9e0b9",
//                                                       "code": "MICROPLAN_MO_08_04_02_01_02_CHILEMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ce4f76c2-f965-45e7-8e5c-87a3619890b6",
//                                                       "code": "MICROPLAN_MO_08_04_02_01_01_NHAYARA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "b4641051-06cf-4eb9-908c-0682667eb5b0",
//                                       "code": "MICROPLAN_MO_08_04_01_ULONGUE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "8a744580-64f8-4b8c-ae42-7a0ed4cbe2a1",
//                                               "code": "MICROPLAN_MO_08_04_01_01_ULONGUE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "0d5182be-e567-4700-a8ad-2828e3db3d3a",
//                                                       "code": "MICROPLAN_MO_08_04_01_01_02_MATCHESSA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4408609b-4f4d-4791-b5c9-bdcea4028751",
//                                                       "code": "MICROPLAN_MO_08_04_01_01_01_NHATE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "6e9b467a-024a-4cab-ad2e-cacba3e2ecc9",
//                               "code": "MICROPLAN_MO_08_03_MACANGA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "2b251a76-142d-4fc5-8b6d-123e14cce054",
//                                       "code": "MICROPLAN_MO_08_03_01_CHIFUNDE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "64f509e2-681f-4ec4-aad7-ea33ef4b84e5",
//                                               "code": "MICROPLAN_MO_08_03_01_01_CHIFUNDE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "82273c84-955a-4435-920c-d375cf35d071",
//                                                       "code": "MICROPLAN_MO_08_03_01_01_02_MACOTI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6dd94ead-6dd7-4aab-b32e-ab9b64788a82",
//                                                       "code": "MICROPLAN_MO_08_03_01_01_01_NHAMAMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "d84591ed-7aef-436e-b286-57345f7a2424",
//                               "code": "MICROPLAN_MO_08_02_MUTARARA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "d2d6bc68-2873-4f9b-93f9-da05c6d626f1",
//                                       "code": "MICROPLAN_MO_08_02_01_MURROTHONE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f83516f3-f9ee-4967-9998-213ff03b779a",
//                                               "code": "MICROPLAN_MO_08_02_01_01_MURROTHONE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b2ac9fe3-c499-46db-ac1c-c695dfe12b9a",
//                                                       "code": "MICROPLAN_MO_08_02_01_01_02_NHAFUCO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6b512d17-58fc-470a-aa67-2ed33f380aff",
//                                                       "code": "MICROPLAN_MO_08_02_01_01_01_CHIMUQUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "3afbe708-de3b-4904-9133-a29872175b0f",
//                               "code": "MICROPLAN_MO_08_01_MOATIZE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "61d7a87a-01de-4899-9e45-0a7c179ff467",
//                                       "code": "MICROPLAN_MO_08_01_01_KANSENGWA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "df28a900-c445-46e2-9e7c-ec10592c1253",
//                                               "code": "MICROPLAN_MO_08_01_01_01_KANSENGWA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "52976052-35af-41d3-a49b-04dd1930c159",
//                                                       "code": "MICROPLAN_MO_08_01_01_01_02_CHIRIMBU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "93483133-a16f-4fba-a044-2b519824df0e",
//                                                       "code": "MICROPLAN_MO_08_01_01_01_01_MURO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "6cada8c0-3d64-4a92-8e77-1cbd2d764827",
//                       "code": "MICROPLAN_MO_07_ZAMBEZIA",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "5f6c30bb-4b30-4f6e-8a5d-023868c4e196",
//                               "code": "MICROPLAN_MO_07_02_NAISSAE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "a3c87bbc-bd28-4958-99c6-d7402451d390",
//                                       "code": "MICROPLAN_MO_07_02_01_NAISSA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "4c15990e-81c8-4cd4-8622-a909fe749165",
//                                               "code": "MICROPLAN_MO_07_02_01_01_NAISSA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "be9ea173-915e-4d32-af8d-ea2fa16646a1",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_30_REGION30",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4a6bd43e-4cfa-427f-879f-064230470cec",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_29_REGION29",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "84fc74fc-71da-42f1-86b5-f4428d8d387d",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_28_REGION28",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "163a688d-3e16-4965-8f20-58892bacfe68",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_27_REGION27",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2360fef4-1800-40ba-922d-d69099325391",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_26_REGION26",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "399f1ad4-f533-4af8-9513-df05ac6ccba9",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_25_REGION25",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2c10a8af-7ca1-4392-b2d1-3124be30650d",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_24_REGION24",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4333c058-b991-4236-a658-93cf8b9dc32f",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_23_REGION23",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b4dabfc2-85fb-4e2f-8956-3c29cc364a59",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_22_REGION22",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "af15677c-e306-48bc-8b18-473109bf28c8",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_21_REGION21",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9cbec2c9-821d-46f1-a2f7-92b2d9900c93",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_20_REGION20",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e0a72334-d3b1-468f-8818-c2988dee0425",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_19_REGION19",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c87d3afa-177b-4d04-bbf0-6e7c55340621",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_18_REGION18",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a45cba4b-5d1e-45a9-8369-0ecaa7530dd8",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_17_REGION17",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0327e57a-19bd-412b-9a0e-c8ff4e342a64",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_16_REGION16",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fd8226b5-2eef-427f-84cf-61f286b27049",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_15_REGION15",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "89424563-ffed-477e-95e5-fe37c307191f",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_14_REGION14",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc1795c7-df07-4aab-96be-5f94c8cd44b2",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_13_REGION13",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d63ec437-5a5a-460d-bd19-796eae94a617",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_12_REGION12",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7bad1c61-798b-4a97-9b4d-f14c5ee14a80",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_11_REGION11",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "38b7a249-e49d-44ab-a569-a64dc03a02fb",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_10_REGION10",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "852f7e3d-8204-4a0a-99ce-2fe010f7d60e",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_09_REGION9",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1a2eec8b-d3a0-4ae4-b8ee-b0968240276e",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_08_REGION8",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9d3bd1fe-88fa-497e-a8de-505a2a832405",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_07_REGION7",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2f3a5be7-b935-4138-92c1-9b4a2f6d914d",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_06_REGION6",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "974df6ae-c64b-42fe-9f4a-55d516f991f6",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_05_REGION5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "959ea229-212e-4915-96db-60b9f3e15d72",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_04_REGION4",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "75262f0d-110a-4ca2-b68a-b7a45fa612ec",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_03_REGION3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6c27dc2e-f329-4927-9f6e-108693cfca49",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_02_REGION2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2155b01e-a1c7-45e5-99f3-72df0b8589c6",
//                                                       "code": "MICROPLAN_MO_07_02_01_01_01_REGION1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "7bfc795d-488c-4df0-a7ba-b87b0c2a4bfa",
//                               "code": "MICROPLAN_MO_07_01_ALTO_MOLOCULE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "c0f4b903-3327-4338-ac81-ea2851214035",
//                                       "code": "MICROPLAN_MO_07_01_01_ALTO_MOLOCUE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "477cfa87-53ef-4f2e-88c9-2230a5de22db",
//                                               "code": "MICROPLAN_MO_07_01_01_01_ALTO_MOLOCUE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e9e32890-0877-4f86-a321-24119d61ad82",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_10_LOCATION10",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b6dff674-d00a-463c-a1ef-912fa98d61b4",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_09_LOCATION9",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "822cae5f-68ff-405a-a07f-d1165fdb7dad",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_08_LOCATION8",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e71cac07-1341-4992-94a0-e57dc6efa881",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_07_LOCATION7",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "35f3632b-0004-403f-a63c-391129223d8c",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_06_LOCATION6",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7c1de405-fd31-4cff-b36f-54558844d37f",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_05_LOCATION5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a9688dd8-d00b-40d5-b668-af3843a0d41e",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_04_LOCATION4",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "70156611-6dca-41eb-98d8-db4351b06959",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_03_LOCATION3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "27c284a0-de20-4942-ab1e-54e31745ab61",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_02_LOCATION2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f2d5e920-e000-447a-9d6f-afe8cb197457",
//                                                       "code": "MICROPLAN_MO_07_01_01_01_01_LOCATION1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "5cb87822-7b15-4f14-834d-33efb40d57c2",
//                       "code": "MICROPLAN_MO_06_INHAMBANE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "23527660-393c-4151-9f65-edc6f9e09886",
//                               "code": "MICROPLAN_MO_06_09_ZAVALAA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "f8456959-00c2-40d0-9486-5849d3703dec",
//                                       "code": "MICROPLAN_MO_06_09_01_ZAVALA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "181d5cd2-c2f1-4827-a1df-1f4a2d3c7ac2",
//                                               "code": "MICROPLAN_MO_06_09_01_01_ZAVALA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4d4dc624-794e-44fc-aa6f-e05601dfb9a8",
//                                                       "code": "MICROPLAN_MO_06_09_01_01_02_MASSINGIR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "30e2a09b-27ae-4c2d-b1d2-e86fea27b260",
//                                                       "code": "MICROPLAN_MO_06_09_01_01_01_MABALANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "f91623ea-c98c-4a5e-999d-9e07025b444c",
//                               "code": "MICROPLAN_MO_06_08_VILANCULOSE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "f6c7319a-fea6-42f0-9359-ccee1bdc7352",
//                                       "code": "MICROPLAN_MO_06_08_01_VILANCULOS",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "8d775393-d306-43e9-9efc-a97dfced7414",
//                                               "code": "MICROPLAN_MO_06_08_01_01_VILANCULOS_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "88b36e1c-a8c2-4b68-8d4a-9602db453d96",
//                                                       "code": "MICROPLAN_MO_06_08_01_01_02_MASSACA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e4c3aaa8-96d4-42b8-8d5c-2fa0500f5f95",
//                                                       "code": "MICROPLAN_MO_06_08_01_01_01_CHINAMANI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "af54fa0a-1d82-4daf-a235-8d9d0272bbae",
//                               "code": "MICROPLAN_MO_06_07_MABOTEE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "b2c3040b-a988-46cf-b5a9-e93e87d7c48b",
//                                       "code": "MICROPLAN_MO_06_07_01_MABOTE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "cfbc8e79-9716-45d7-988a-d9f333c269d8",
//                                               "code": "MICROPLAN_MO_06_07_01_01_MABOTE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a2d0168a-c018-46e9-8cb8-4b27801138c7",
//                                                       "code": "MICROPLAN_MO_06_07_01_01_03_MAPAI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "efc5ebd0-1544-4bde-9eb2-bfd16012ebd9",
//                                                       "code": "MICROPLAN_MO_06_07_01_01_02_MACHANGULO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6a541532-5881-4b92-a218-2ab34fe872e4",
//                                                       "code": "MICROPLAN_MO_06_07_01_01_01_CHIMANCHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "cae5e365-a093-4146-aae9-0eefa8bab7f7",
//                               "code": "MICROPLAN_MO_06_06_INHASSOROE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "af91971d-d091-49df-9015-0a17510053d8",
//                                       "code": "MICROPLAN_MO_06_06_01_INHASSORO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "9f31952d-3c16-46c9-a4e8-1621561eee96",
//                                               "code": "MICROPLAN_MO_06_06_01_01_INHASSORO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "82c97b61-be53-4d08-bd2a-d8145f05ea27",
//                                                       "code": "MICROPLAN_MO_06_06_01_01_02_CHIMACUALA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cc344545-fd94-4ec4-9505-ab419e14b072",
//                                                       "code": "MICROPLAN_MO_06_06_01_01_01_MACATANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "d3ef24c3-9798-45ef-a5fc-178236f672d1",
//                               "code": "MICROPLAN_MO_06_05_FUNHALOUROA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "15a3d381-4df4-4053-87dd-66cce4e48d65",
//                                       "code": "MICROPLAN_MO_06_05_01_FUNHALOURO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "37b07be5-e92e-4ca4-b066-9302f1034286",
//                                               "code": "MICROPLAN_MO_06_05_01_01_FUNHALOURO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7e7b35dd-6fc0-423d-9b27-f6a7f3d94df0",
//                                                       "code": "MICROPLAN_MO_06_05_01_01_03_MALIPA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "921fa644-4177-4a83-adbc-e47f17b54f8f",
//                                                       "code": "MICROPLAN_MO_06_05_01_01_02_CHICUALACUALA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "57974d4b-1b64-47d2-8411-d8e3ef9f9cd9",
//                                                       "code": "MICROPLAN_MO_06_05_01_01_01_CHICOA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "ca6119f6-cd9a-4c21-88bd-1c1c13af60ce",
//                               "code": "MICROPLAN_MO_06_04_MAXIXEE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "d61ab5d4-272b-4569-9d64-7482ce6f916c",
//                                       "code": "MICROPLAN_MO_06_04_01_MAXIXE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "20147cb3-1d62-46a8-92e2-5dad9c3ba5cf",
//                                               "code": "MICROPLAN_MO_06_04_01_01_MAXIXE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4bc639c3-f8cb-4b26-94d5-80aac90f2768",
//                                                       "code": "MICROPLAN_MO_06_04_01_01_03_MACUANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "94c3225f-fd56-49a3-ae96-2bcf930d558b",
//                                                       "code": "MICROPLAN_MO_06_04_01_01_02_CHIMBONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "71492bdb-b285-4951-8c24-e6dc170c515b",
//                                                       "code": "MICROPLAN_MO_06_04_01_01_01_MUABSA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "cc75d852-5385-48b9-b889-5f72d8ba1a6d",
//                               "code": "MICROPLAN_MO_06_03_MASSINGAA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "fef1b232-f6a6-4232-b273-107df7602d8a",
//                                       "code": "MICROPLAN_MO_06_03_01_MASSINGA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "06544974-790f-4152-8825-fd6855ebbc06",
//                                               "code": "MICROPLAN_MO_06_03_01_01_MASSINGA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a8893805-646c-4b6d-a0fc-8eae74cb628f",
//                                                       "code": "MICROPLAN_MO_06_03_01_01_06_CHIBUTOOO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a738b342-ac21-4dbb-84de-6e4bcd3245a7",
//                                                       "code": "MICROPLAN_MO_06_03_01_01_05_MASSINGIRI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2258a799-9975-4889-9e3a-e9907eb8c563",
//                                                       "code": "MICROPLAN_MO_06_03_01_01_04_MACUANEEE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a786a92b-9f55-40f9-8a92-538885edbcd7",
//                                                       "code": "MICROPLAN_MO_06_03_01_01_03_CHICOAA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "70d442cb-08a8-4f0e-88bc-2d2a47bd426a",
//                                                       "code": "MICROPLAN_MO_06_03_01_01_02_CHICOMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d9783739-8a65-4e5a-984f-a3f9898de968",
//                                                       "code": "MICROPLAN_MO_06_03_01_01_01_MACUACHENE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "b8850e65-4a51-4248-9e1c-9ec3b990ae21",
//                               "code": "MICROPLAN_MO_06_02_JANGAMOO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "357dd12a-6be9-4ecd-9abf-4f2befb79c52",
//                                       "code": "MICROPLAN_MO_06_02_01_JANGAMO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "91ae14a9-c0f8-4c04-ad55-61cd7d18cf0d",
//                                               "code": "MICROPLAN_MO_06_02_01_01_JANGAMO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c823a74e-03a7-4af7-8b6e-dbc60a451103",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_07_MACUANE11",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "62f62722-44a8-4f5b-87b0-adf55b1411c7",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_06_MASSINGAI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d389823a-81b8-4c3a-9b00-e5c0e15dc609",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_05_CHIMACUALAA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "71fbe609-3c61-42d5-b56e-9b42dafbbf42",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_04_CHIBUTO1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2ad301cf-8d17-4ba1-a045-869170e1d880",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_03_CHICUZAI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "96b95820-6f15-4b10-9a83-565d36846e85",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_02_CHIDENGUELE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f2e8f9fb-13d3-4ea3-b346-7003f72b0626",
//                                                       "code": "MICROPLAN_MO_06_02_01_01_01_MASSACATE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "e1656e77-cb1d-4950-a684-59fc9209fccc",
//                               "code": "MICROPLAN_MO_06_01_INHARRIMEA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "426ec4a3-0291-4445-a863-10fd9dbfcdaf",
//                                       "code": "MICROPLAN_MO_06_01_01_INHARRIME",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "8b4f960b-d548-402b-a9ff-78de2489de16",
//                                               "code": "MICROPLAN_MO_06_01_01_01_INHARRIME_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "fb3cbd18-2fd7-45eb-b8e7-617ebd69b670",
//                                                       "code": "MICROPLAN_MO_06_01_01_01_03_CHIBUTO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1a365671-1e35-470d-84a1-b104d324834b",
//                                                       "code": "MICROPLAN_MO_06_01_01_01_02_CHACAME",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "98721a23-67cf-4d63-8ef6-6fbc5a67637c",
//                                                       "code": "MICROPLAN_MO_06_01_01_01_01_MASSINGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "1f2a5953-357c-4441-901f-0a094994e707",
//                       "code": "MICROPLAN_MO_05_GAZA",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "5c51293b-f104-4d60-bf90-e21392e81d36",
//                               "code": "MICROPLAN_MO_05_09_BILENE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "46538c3d-b3bc-40f7-b89e-9d8ef14c0608",
//                                       "code": "MICROPLAN_MO_05_09_01_BILENEE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f02c696d-8175-46a9-9d03-0387827fa78f",
//                                               "code": "MICROPLAN_MO_05_09_01_01_BILENE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "54a5905a-4712-42a5-9846-30cc3957b206",
//                                                       "code": "MICROPLAN_MO_05_09_01_01_02_MACANETA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6277ef7a-c2eb-4d5d-a007-75df0c7bc8f3",
//                                                       "code": "MICROPLAN_MO_05_09_01_01_01_MASSACHO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "ae474181-f34b-4812-943d-9464f6eb0def",
//                               "code": "MICROPLAN_MO_05_08_MABALANE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "ed878d4b-3d19-4d7a-9d30-e5586f4157f2",
//                                       "code": "MICROPLAN_MO_05_08_01_MABALANEE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "bcf14be7-5d07-468c-a675-904da2fb4e7f",
//                                               "code": "MICROPLAN_MO_05_08_01_01_MABALANE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "e8db2d97-c590-42ff-8c34-85047504a01e",
//                                                       "code": "MICROPLAN_MO_05_08_01_01_02_MAPAI_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4fc9df2e-cd3e-42b4-b338-5c56c9a2406b",
//                                                       "code": "MICROPLAN_MO_05_08_01_01_01_CHIGUBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "a8b17989-6ae5-4a6c-acf4-f74693749b87",
//                               "code": "MICROPLAN_MO_05_07_MASSINGIR",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "6a48675e-7b4f-4d50-8d17-adf01788cf02",
//                                       "code": "MICROPLAN_MO_05_07_01_MASSINGIR_PA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "aa2caa39-738a-4383-b8be-4d3af8c83099",
//                                               "code": "MICROPLAN_MO_05_07_01_01_MASSINGIR_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8872738b-85dc-4d46-b4a6-2fb6edcc00e0",
//                                                       "code": "MICROPLAN_MO_05_07_01_01_01_MACHANGULO_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "18866d3c-abf9-4ce9-931a-24bbfb94b968",
//                               "code": "MICROPLAN_MO_05_06_XAI_XAI",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "f662eae7-5e41-4e08-a029-f83efbba6d40",
//                                       "code": "MICROPLAN_MO_05_06_01_XAI_XAI_PA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "fb3cccf9-1d36-4154-bc17-6e521f65200c",
//                                               "code": "MICROPLAN_MO_05_06_01_01_XAI_XAI_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9f5d37fb-9f8c-4025-a409-c999e7001a9a",
//                                                       "code": "MICROPLAN_MO_05_06_01_01_03_CHICOMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6e9b00bd-9cd6-463b-b216-9ea88f62f56c",
//                                                       "code": "MICROPLAN_MO_05_06_01_01_02_MATIMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b9bc1c89-514d-4fbf-9d2c-6c38412462f5",
//                                                       "code": "MICROPLAN_MO_05_06_01_01_01_CHILANGANA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "57818731-fef6-485e-98b2-f74e6c3bfa8c",
//                               "code": "MICROPLAN_MO_05_05_MANJACAZE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "7fb21999-0a30-4a6a-ae6e-e0a8f50bf135",
//                                       "code": "MICROPLAN_MO_05_05_01_MANJACAZEE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "5df04c7c-0381-4c2e-8879-2a7f61943bd4",
//                                               "code": "MICROPLAN_MO_05_05_01_01_MANJACAZE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "44fc5414-88d3-4819-962e-d6d1d697076e",
//                                                       "code": "MICROPLAN_MO_05_05_01_01_02_MACARRETANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "93fe23e5-7078-4b90-a851-681bb511a3c8",
//                                                       "code": "MICROPLAN_MO_05_05_01_01_01_CHIDENGUELE_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "329262b8-5acf-4659-9406-72ec4d0424e3",
//                               "code": "MICROPLAN_MO_05_04_LIMPOPO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "d5c0f367-75fc-4d22-acb0-cd9a814dc423",
//                                       "code": "MICROPLAN_MO_05_04_01_LIMPOPOQ",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "240f580a-ab7c-4f5a-bcd7-8ed0c8f8dce0",
//                                               "code": "MICROPLAN_MO_05_04_01_01_LIMPOPO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "3c76a3bb-fc62-4cf4-94dd-846bd71d66d7",
//                                                       "code": "MICROPLAN_MO_05_04_01_01_03_MALE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9b454ba9-e85a-428f-b96d-0f97219e0d86",
//                                                       "code": "MICROPLAN_MO_05_04_01_01_02_MASSINGIR_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a026d778-e50f-4f24-93b2-75aba9d15798",
//                                                       "code": "MICROPLAN_MO_05_04_01_01_01_MACUACUA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "718d9bdd-afd3-442e-b9e5-eab644e088a5",
//                               "code": "MICROPLAN_MO_05_03_GUIJA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "3e5639e9-8fe4-4a4f-ae8f-e75f2d7e5d52",
//                                       "code": "MICROPLAN_MO_05_03_01_GUIJAA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "1bdd5f02-2de4-441c-b624-aebff52ac6de",
//                                               "code": "MICROPLAN_MO_05_03_01_01_GUIJA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "23b95455-0145-456d-a96d-e415008a1e9e",
//                                                       "code": "MICROPLAN_MO_05_03_01_01_03_CHIBALO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba738073-ea53-4dd0-97f2-ac8e418c1bf1",
//                                                       "code": "MICROPLAN_MO_05_03_01_01_02_MABALANE_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "83bea27d-fe7c-4474-a13d-afcf9666eb79",
//                                                       "code": "MICROPLAN_MO_05_03_01_01_01_MASSANGENA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "f1387aae-f4f4-4c9b-b72f-73335ac778b2",
//                               "code": "MICROPLAN_MO_05_02_CHOKWE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "5625fc72-88ab-48e5-9255-40c4b7c3319f",
//                                       "code": "MICROPLAN_MO_05_02_01_CHOKWEE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "9b1ba4e7-c63d-4fae-9ea5-f63a64737822",
//                                               "code": "MICROPLAN_MO_05_02_01_01_CHOKWE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c89b1075-e344-4869-ba86-9193ce091011",
//                                                       "code": "MICROPLAN_MO_05_02_01_01_02_CHIBONGO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9af88e12-59ef-4d88-b07e-976785ad8ac4",
//                                                       "code": "MICROPLAN_MO_05_02_01_01_01_MACIA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "1aaf36b2-f089-4dd9-808e-0fe88f267b54",
//                               "code": "MICROPLAN_MO_05_01_CHIBUTO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "050b8b08-612b-4514-b7a7-368b8a289bed",
//                                       "code": "MICROPLAN_MO_05_01_01_CHIBUTOO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "22b62d88-a171-4044-9392-7c04e4b40266",
//                                               "code": "MICROPLAN_MO_05_01_01_01_CHIBUTO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b0cf38a2-f33c-4bcf-a6bb-38542518b9d0",
//                                                       "code": "MICROPLAN_MO_05_01_01_01_03_CHANGANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "121f6583-ac09-47ec-8504-14079de73a86",
//                                                       "code": "MICROPLAN_MO_05_01_01_01_02_CHICUZA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "141119f4-f01d-4dcf-9fad-bf93cfea2d52",
//                                                       "code": "MICROPLAN_MO_05_01_01_01_01_MAPA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "541eef34-06e9-4169-86ac-3ae43440bb5d",
//                       "code": "MICROPLAN_MO_04_MAPUTO",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "24e97433-259b-495b-8c7e-5572c90f7224",
//                               "code": "MICROPLAN_MO_04_07_NOME",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "121ee4f9-e85c-4b4d-8db5-8af060da5d94",
//                                       "code": "MICROPLAN_MO_04_07_01_NOMEA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "03167cff-0eab-4027-aada-478eb753dbac",
//                                               "code": "MICROPLAN_MO_04_07_01_01_NOME_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "caa58788-9461-4c60-a2f6-a9321318910a",
//                                                       "code": "MICROPLAN_MO_04_07_01_01_02_NHAMATE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "198d3266-0e23-48d2-bcbc-4f58884f73ea",
//                                                       "code": "MICROPLAN_MO_04_07_01_01_01_CHIMUANA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "78bb6b8d-1b39-478a-b033-2c6c45088364",
//                               "code": "MICROPLAN_MO_04_06_MOA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "c3f9efdf-283a-4577-ac0a-efae689a7fc4",
//                                       "code": "MICROPLAN_MO_04_06_01_MOAA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "35eb49dd-7a2a-43f9-a15d-d8022082c6ab",
//                                               "code": "MICROPLAN_MO_04_06_01_01_MOA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "a82e29a9-5eaf-4f82-a9b5-d810fb8a7b0d",
//                                                       "code": "MICROPLAN_MO_04_06_01_01_02_MASSIFUTA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d8cd21b4-048b-455b-ad43-2b27daee35a8",
//                                                       "code": "MICROPLAN_MO_04_06_01_01_01_CHICUALACUALA_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "e2989fba-c2c6-4115-917a-44229ba8fa0a",
//                               "code": "MICROPLAN_MO_04_05_MANHICA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "b05a2016-c3f6-4392-9041-c4808df064d5",
//                                       "code": "MICROPLAN_MO_04_05_01_MANHICAE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "da88034a-8ea3-46ec-88fe-3056f227a299",
//                                               "code": "MICROPLAN_MO_04_05_01_01_MANHICA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7ea79f53-b002-4023-b939-f6ce1a2c32e6",
//                                                       "code": "MICROPLAN_MO_04_05_01_01_02_MACALANGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b4a6875f-c0fb-49e7-ad90-a5cddc6d8679",
//                                                       "code": "MICROPLAN_MO_04_05_01_01_01_MASSACANHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "6ea705e0-f795-454b-8a5d-2f3d113b4c0e",
//                               "code": "MICROPLAN_MO_04_04_MAGUDE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "2f424476-0853-4bc5-8324-884f5d4ea196",
//                                       "code": "MICROPLAN_MO_04_04_01_MAGUDEE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "3164e9b6-b9d1-4e6a-9569-0ec1f882335b",
//                                               "code": "MICROPLAN_MO_04_04_01_01_MAGUDE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "8fa2e4b0-b3f8-4f9e-92d4-184c9aacd278",
//                                                       "code": "MICROPLAN_MO_04_04_01_01_04_CHICHACHAEW",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "04946845-0004-4a23-b8da-75786ddbb166",
//                                                       "code": "MICROPLAN_MO_04_04_01_01_03_MASSINGA_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "996c9b7e-5dd4-4678-ab20-34e966bcbd05",
//                                                       "code": "MICROPLAN_MO_04_04_01_01_02_NHAMACONDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "742ea42f-54fb-40f1-a536-1ed1f1c52848",
//                                                       "code": "MICROPLAN_MO_04_04_01_01_01_MAPULANGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "8aeb8f67-5ef1-4aaa-994e-c5e445b7756f",
//                               "code": "MICROPLAN_MO_04_03_MARRACUENE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "8de6f9e8-a37b-42b8-b5e9-fd23ca201928",
//                                       "code": "MICROPLAN_MO_04_03_01_MARRACUENEE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "39501729-0a55-423d-a03a-6f2a217257e1",
//                                               "code": "MICROPLAN_MO_04_03_01_01_MARRACUENE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b160a33c-d414-4a68-a351-00a89b3dfd9b",
//                                                       "code": "MICROPLAN_MO_04_03_01_01_04_MAJACAZAI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "59ff4c26-55db-4329-ac4a-52c23c767070",
//                                                       "code": "MICROPLAN_MO_04_03_01_01_03_MANGUNHANEII",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ff9e9fc8-e58e-470b-b0d7-488d332d8ed1",
//                                                       "code": "MICROPLAN_MO_04_03_01_01_02_MAZIVE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "52da842b-5bbd-43f9-b492-2b0363f22016",
//                                                       "code": "MICROPLAN_MO_04_03_01_01_01_MACANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "100f7912-fabd-41ba-b95c-561bae843c48",
//                               "code": "MICROPLAN_MO_04_02_BOANE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "3b822d03-e35c-4e96-8bc2-2855a4f96831",
//                                       "code": "MICROPLAN_MO_04_02_01_BOANE_VISTA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "c8bfc724-666e-4898-8b80-aff12450e14f",
//                                               "code": "MICROPLAN_MO_04_02_01_01_BOANE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ed69db44-e359-4231-8ae8-3dbb87ea2ad0",
//                                                       "code": "MICROPLAN_MO_04_02_01_01_04_CHANGAMBE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1bd41561-b4f3-4fa7-b18d-5c1b4323d52c",
//                                                       "code": "MICROPLAN_MO_04_02_01_01_03_MAGULUCO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef04cd54-4b28-4f11-b011-fe7f5eabc27b",
//                                                       "code": "MICROPLAN_MO_04_02_01_01_02_MUBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5b25551c-9299-401c-be9d-b9c7f57e9bbf",
//                                                       "code": "MICROPLAN_MO_04_02_01_01_01_NDUMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "2b0801ca-89cd-46ec-9623-69857a98905a",
//                               "code": "MICROPLAN_MO_04_01_MATUTUINE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "5b5fff1f-fc06-42ae-bd44-acf08d0e0687",
//                                       "code": "MICROPLAN_MO_04_01_01_BELA_VISTA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d2556041-fa31-4948-ae21-8cd611dd1bab",
//                                               "code": "MICROPLAN_MO_04_01_01_01_BELA_VISTA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6d24a327-bab2-4652-99c7-2521b9089360",
//                                                       "code": "MICROPLAN_MO_04_01_01_01_04_CHAVANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "aae5d38e-e248-43da-9974-3d8b7b57c62c",
//                                                       "code": "MICROPLAN_MO_04_01_01_01_03_MASSUNGULO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8de1b5c8-7593-4f3f-a0b6-ddbfb8d7c43d",
//                                                       "code": "MICROPLAN_MO_04_01_01_01_02_NHAMBAZA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "821e3a1b-0d80-409e-89b1-b8a64b544490",
//                                                       "code": "MICROPLAN_MO_04_01_01_01_01_MASSAVANE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "977bea64-cc7e-4bbe-a9e8-b9fd4f07a6f6",
//                       "code": "MICROPLAN_MO_03_SOFALA",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "41989011-ff55-4cff-ba9d-bd735715ff32",
//                               "code": "MICROPLAN_MO_03_06_CAIA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "9a980fca-8f8c-44c5-9e4a-1962ae9a2ad6",
//                                       "code": "MICROPLAN_MO_03_06_04_MOPEIA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b9417d97-5cbd-4b13-8687-8e831d81f98b",
//                                               "code": "MICROPLAN_MO_03_06_04_01_MOPEIA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9132cd46-91d4-4d62-a899-6c37b7a33214",
//                                                       "code": "MICROPLAN_MO_03_06_04_01_02_LICUMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0181ae9c-3e66-4cd3-8901-2586982ffd06",
//                                                       "code": "MICROPLAN_MO_03_06_04_01_01_MAZUQUA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "35a24c65-1223-4ff2-8461-0c1ef8f1ee1e",
//                                       "code": "MICROPLAN_MO_03_06_03_CHIMUARA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "6ac37ca0-cb3b-49b9-adbc-a7d0e315d119",
//                                               "code": "MICROPLAN_MO_03_06_03_01_CHIMUARA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7a9e6f3b-3885-4301-a642-a27c2ed5300e",
//                                                       "code": "MICROPLAN_MO_03_06_03_01_02_NHASSICO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4c0c6fbf-6606-4b34-85fd-5c03f8aa32e5",
//                                                       "code": "MICROPLAN_MO_03_06_03_01_01_MAFOGUENE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "97ce30a9-538b-45c5-86a3-7f4fc3e9a123",
//                                       "code": "MICROPLAN_MO_03_06_02_MURRA_A",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "c2ea3f8c-b2d1-4c68-ac56-c21f47f9bcc3",
//                                               "code": "MICROPLAN_MO_03_06_02_01_MURRA_A_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "3c7dc46b-71b7-4eea-822e-fcefb71f8462",
//                                                       "code": "MICROPLAN_MO_03_06_02_01_02_MACHUMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a9e333e4-3ce8-4590-81df-26380f915b51",
//                                                       "code": "MICROPLAN_MO_03_06_02_01_01_NHIRO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "d346e7cb-5fbb-4361-916c-325b82c79701",
//                                       "code": "MICROPLAN_MO_03_06_01_SENA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "7eaa71ae-a089-45bc-968c-03a11d94e374",
//                                               "code": "MICROPLAN_MO_03_06_01_01_SENA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9a3892ff-baea-4c3b-9b65-6b63c0c754e9",
//                                                       "code": "MICROPLAN_MO_03_06_01_01_02_MACHANGULO_02",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a794d7e5-1122-4374-adcc-7839af936a34",
//                                                       "code": "MICROPLAN_MO_03_06_01_01_01_CHIMBUNGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "1e0d2d16-e840-49d0-9a7f-aa9759dc1103",
//                               "code": "MICROPLAN_MO_03_05_CHEMBA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "f9f0df5b-acb7-43ca-914e-8f057637c375",
//                                       "code": "MICROPLAN_MO_03_05_04_INHANGOMA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "1be5df5d-c122-4d4b-b6cc-6ed416f94e54",
//                                               "code": "MICROPLAN_MO_03_05_04_01_INHANGOMA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "2d9aff2c-8f20-4533-b038-633601e3b314",
//                                                       "code": "MICROPLAN_MO_03_05_04_01_02_MACAHULO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "738c5bbd-1cde-427f-a3e3-5f6e72bfb0a6",
//                                                       "code": "MICROPLAN_MO_03_05_04_01_01_MECHUO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "487310ba-4098-43de-9d72-c0ccd39235fa",
//                                       "code": "MICROPLAN_MO_03_05_03_MORRUMBALA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "59a8753e-2726-43e2-bd94-33d9074303b8",
//                                               "code": "MICROPLAN_MO_03_05_03_01_MORRUMBALA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7a717188-b700-412b-a591-a344673324bf",
//                                                       "code": "MICROPLAN_MO_03_05_03_01_02_NHAXANA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cf96f13d-1b31-416f-b4b9-d7df7a0ac170",
//                                                       "code": "MICROPLAN_MO_03_05_03_01_01_MACAVALA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "2273ecaf-4175-4767-b7a3-468ca2e01f54",
//                                       "code": "MICROPLAN_MO_03_05_02_CHUPANGA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "46c554bd-ba00-40fb-9c8e-0dd61a8091ba",
//                                               "code": "MICROPLAN_MO_03_05_02_01_CHUPANGA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "45af1522-b509-492c-bab5-2a1e0782f6b8",
//                                                       "code": "MICROPLAN_MO_03_05_02_01_02_MACUNHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "428cf943-74de-452c-aacf-89870c16d66c",
//                                                       "code": "MICROPLAN_MO_03_05_02_01_01_MATEQUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "7cddb49f-7526-42ae-bbcd-facbec6bfd2f",
//                                       "code": "MICROPLAN_MO_03_05_01_MARROMEU",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "d8bc8683-26ec-497b-ad37-e1708977b2d1",
//                                               "code": "MICROPLAN_MO_03_05_01_01_MARROMEU_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "eff7a256-8e63-4f67-a58e-7a5cb18b41d4",
//                                                       "code": "MICROPLAN_MO_03_05_01_01_02_MEQUELE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b2d07253-7bad-4a52-8ab1-e60176d339b6",
//                                                       "code": "MICROPLAN_MO_03_05_01_01_01_CHAMBULI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "6ad7f756-0700-40dd-a664-337ccb473723",
//                               "code": "MICROPLAN_MO_03_04_BUZI",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "11d392df-28cb-4988-ba5a-fcc7a9dc557a",
//                                       "code": "MICROPLAN_MO_03_04_04_GUARA_GUARA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "af98cc37-9d3d-4567-a4d8-f5a3dc0d969f",
//                                               "code": "MICROPLAN_MO_03_04_04_01_GUARA_GUARA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "bc1f11f2-5ea8-41c9-bcfc-3ba916140127",
//                                                       "code": "MICROPLAN_MO_03_04_04_01_02_MACHUMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "89fbc257-9d31-4766-9b6d-8b86922667d4",
//                                                       "code": "MICROPLAN_MO_03_04_04_01_01_MAHORO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f6965fe6-7b7f-461c-8db9-f72b13bb192e",
//                                       "code": "MICROPLAN_MO_03_04_03_GRUDJA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "cfa112bc-f6b9-434e-891c-de937aba9855",
//                                               "code": "MICROPLAN_MO_03_04_03_01_GRUDJA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "9bc01377-da66-4ab3-a4a7-c4bc79054e2b",
//                                                       "code": "MICROPLAN_MO_03_04_03_01_02_CHICUARI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ab072b9a-e0c0-4475-8e8e-66a9416de45a",
//                                                       "code": "MICROPLAN_MO_03_04_03_01_01_MAZACHA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "571f36b4-c297-4363-b865-a44134c6c299",
//                                       "code": "MICROPLAN_MO_03_04_02_INHAMINGA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "812b9446-751c-4080-b871-1900256fff13",
//                                               "code": "MICROPLAN_MO_03_04_02_01_INHAMINGA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "79a6b902-01cb-42ba-8c88-10bfb7d51734",
//                                                       "code": "MICROPLAN_MO_03_04_02_01_02_MUZOMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a448a217-495f-4d46-b520-d07cf37ade8f",
//                                                       "code": "MICROPLAN_MO_03_04_02_01_01_NHOHULA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "fa837388-0253-4d99-b420-6ce7f010182e",
//                                       "code": "MICROPLAN_MO_03_04_01_NOVA_SOFALA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "622ca243-062b-4a81-a6bf-e5eefc565fe7",
//                                               "code": "MICROPLAN_MO_03_04_01_01_NOVA_SOFALA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "fd807733-ab66-41b4-af12-a4ea094002dc",
//                                                       "code": "MICROPLAN_MO_03_04_01_01_02_CHICENGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "78080ee2-e0fd-49d1-aec6-d67050fe5010",
//                                                       "code": "MICROPLAN_MO_03_04_01_01_01_SENGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "32b48c77-036a-4e89-8144-e715dc45bd9b",
//                               "code": "MICROPLAN_MO_03_03_GORONGOSA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "4ef93b94-ab02-4b7f-80cb-46b4ea0896a5",
//                                       "code": "MICROPLAN_MO_03_03_04_DINDIZA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "f00eedc1-40a9-44c7-8761-ad29b4dcbe1d",
//                                               "code": "MICROPLAN_MO_03_03_04_01_DINDIZA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "09f32a01-1e20-4086-805b-231268e4adab",
//                                                       "code": "MICROPLAN_MO_03_03_04_01_02_NHANJI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "52da9df6-2307-469a-aacb-694b90b93414",
//                                                       "code": "MICROPLAN_MO_03_03_04_01_01_LAMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "1b0c688e-e4c8-4989-8156-38d21cd1e534",
//                                       "code": "MICROPLAN_MO_03_03_03_NHAMASSONGE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "6579dd5e-768f-448c-a32b-4315b08d5bc3",
//                                               "code": "MICROPLAN_MO_03_03_03_01_NHAMASSONGE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "c07f7433-0472-468d-b983-22e3334757e5",
//                                                       "code": "MICROPLAN_MO_03_03_03_01_02_NHANDJA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "956de8ad-a76a-40a9-bdcc-d3da2edfd596",
//                                                       "code": "MICROPLAN_MO_03_03_03_01_01_NHATADIMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "1ca971f0-8bbc-4caa-b460-bf9c50c98d0b",
//                                       "code": "MICROPLAN_MO_03_03_02_CHITUNGA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "c864b089-7c41-40d3-8bad-098d0a283523",
//                                               "code": "MICROPLAN_MO_03_03_02_01_CHITUNGA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "34e2faa4-4cfc-40f1-a632-f86229b944b9",
//                                                       "code": "MICROPLAN_MO_03_03_02_01_02_MACUNGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2964196f-9493-4046-a6bf-0d4ce417403f",
//                                                       "code": "MICROPLAN_MO_03_03_02_01_01_MILANGULO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "5f9c3f28-9848-436c-85f1-1b2debaaabeb",
//                                       "code": "MICROPLAN_MO_03_03_01_VUNDUZI",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "291a2446-e323-4da5-89fe-7934634e9253",
//                                               "code": "MICROPLAN_MO_03_03_01_01_VUNDUZI_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "7acafa1c-94b3-4bf6-8778-1f8022bd1050",
//                                                       "code": "MICROPLAN_MO_03_03_01_01_02_MAVICHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1cf32516-1d85-4a25-8f6d-086354c1251e",
//                                                       "code": "MICROPLAN_MO_03_03_01_01_01_MARANGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "51b006e3-ce83-45fa-a66e-7bc5d64871b6",
//                               "code": "MICROPLAN_MO_03_02_DONDO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "60a795d5-01c7-44bc-a14f-81b32070bc30",
//                                       "code": "MICROPLAN_MO_03_02_04_SENGO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "48185e23-6e62-422b-adab-1e33af48b03f",
//                                               "code": "MICROPLAN_MO_03_02_04_01_SENGO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "ebc5deeb-b2cb-49e4-abfd-ddaf46e6e978",
//                                                       "code": "MICROPLAN_MO_03_02_04_01_02_MACHIR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "76f65970-077e-4e35-b9a0-535975d359ae",
//                                                       "code": "MICROPLAN_MO_03_02_04_01_01_MARUJA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "2c3f3269-620a-4fdb-9d0e-00a4c044c501",
//                                       "code": "MICROPLAN_MO_03_02_03_CHINAMACONDO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "32ff64b2-605c-4edf-89d9-8ad53eba3608",
//                                               "code": "MICROPLAN_MO_03_02_03_01_CHINAMACONDO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f2676425-c2d7-4523-b1ff-fd2196004c3e",
//                                                       "code": "MICROPLAN_MO_03_02_03_01_02_LICUARI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3b66b78a-e77b-4a8d-899b-54cb8489c951",
//                                                       "code": "MICROPLAN_MO_03_02_03_01_01_MAZONDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "c3ca41d7-cb09-47bd-b7c3-b83032ca889c",
//                                       "code": "MICROPLAN_MO_03_02_02_MAFAMBISSE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "8cda22d8-be82-493e-83ad-9dc37598ca2f",
//                                               "code": "MICROPLAN_MO_03_02_02_01_MAFAMBISSE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "2ca65c91-3bd6-4ca9-92f7-84234e88e1a0",
//                                                       "code": "MICROPLAN_MO_03_02_02_01_02_NHATEMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "79206d4a-b225-4269-95af-83647acf4f5d",
//                                                       "code": "MICROPLAN_MO_03_02_02_01_01_MAGOMBE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "6371735b-e9cb-463b-a6b0-9bb8ed36355f",
//                                       "code": "MICROPLAN_MO_03_02_01_SAVANE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "dd9d19c2-f363-489d-822d-d0bcd30dce69",
//                                               "code": "MICROPLAN_MO_03_02_01_01_SAVANE_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b8a0bda3-f62c-4ae5-98d2-282b30b77094",
//                                                       "code": "MICROPLAN_MO_03_02_01_01_02_MANIKA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1e36ee3a-ee87-4ae8-9de8-f8e9b6a60ed2",
//                                                       "code": "MICROPLAN_MO_03_02_01_01_01_NHAMUDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "afff8db6-7e01-4199-ac63-fd146fa9bf14",
//                               "code": "MICROPLAN_MO_03_01_NHAMATANDA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "6eabd5e9-e47e-4f0e-a49e-5b89d82de66c",
//                                       "code": "MICROPLAN_MO_03_01_05_BEBEDO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "58a1b657-a462-48c8-bd51-cf1b641da3b4",
//                                               "code": "MICROPLAN_MO_03_01_05_01_BEBEDO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "b9ad4370-af85-49f1-9d78-ca686854eed5",
//                                                       "code": "MICROPLAN_MO_03_01_05_01_01_BEBEDO_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "6c139b83-d5db-4e2f-bcb3-a327d3dec6ae",
//                                       "code": "MICROPLAN_MO_03_01_04_LAMEGO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "0e0ba506-0df3-4a1a-b1de-ffa958bc50ca",
//                                               "code": "MICROPLAN_MO_03_01_04_01_LAMEGO_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "15c616d6-2b25-4ccd-b86d-4ff92390c36c",
//                                                       "code": "MICROPLAN_MO_03_01_04_01_02_NHACOTA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fd66215d-9e6a-445e-a511-ade68870441f",
//                                                       "code": "MICROPLAN_MO_03_01_04_01_01_MACANDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "f5711d1b-5f66-4419-bb48-2f7f0f6ef489",
//                                       "code": "MICROPLAN_MO_03_01_03_MUTUA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "10a24c6e-beb3-494e-b0d9-7fba05c6d4fd",
//                                               "code": "MICROPLAN_MO_03_01_03_01_MUTUA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "d778574b-777d-4752-8e7a-bcb6fda4a901",
//                                                       "code": "MICROPLAN_MO_03_01_03_01_02_MAHAMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9d4083cd-48e1-4193-ae49-b750b3200764",
//                                                       "code": "MICROPLAN_MO_03_01_03_01_01_NHANDUMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "b70a280e-d0b5-4df2-a02a-ae79b2ad8783",
//                                       "code": "MICROPLAN_MO_03_01_02_NHAMPOCA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "023a205a-12d3-4b8b-a36f-26c0d22496e8",
//                                               "code": "MICROPLAN_MO_03_01_02_01_NHAMPOCA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "21e9d178-0ade-4b2a-bb80-d331a3d67b14",
//                                                       "code": "MICROPLAN_MO_03_01_02_01_02_SANGO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0e003849-a5db-4cde-a6b8-d11242050572",
//                                                       "code": "MICROPLAN_MO_03_01_02_01_01_MUBO_01",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "65c61a5d-6b08-47e8-a4a1-e21805c346b0",
//                                       "code": "MICROPLAN_MO_03_01_01_TICA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "84d1ea27-caea-4449-9a82-5574ca3d98f7",
//                                               "code": "MICROPLAN_MO_03_01_01_01_TICA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6eff6722-4e08-4dad-ba25-0e211df583f7",
//                                                       "code": "MICROPLAN_MO_03_01_01_01_02_MUCHAPA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b7f8bd0b-99bf-494f-81f7-27dcdb31a8aa",
//                                                       "code": "MICROPLAN_MO_03_01_01_01_01_MUZIRO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "3ac79bad-f60a-499b-af2e-a8f647613ffc",
//                       "code": "MICROPLAN_MO_02_CABO",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "94cb9b70-2ca2-4c9f-b795-a9632ce13280",
//                               "code": "MICROPLAN_MO_02_01_CABO_DELGADO",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "93323877-6b85-43a3-afcf-49326764d632",
//                                       "code": "MICROPLAN_MO_02_01_01_PEMBA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "b3ff1ef9-8478-4f07-9164-5f4d5e048d8e",
//                                               "code": "MICROPLAN_MO_02_01_01_01_PEMBA_SEDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "6e423d1e-a3e2-47f6-871d-3d77fcf4fd72",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_43_CABATA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "703df0d4-5fbb-4474-9fb7-d6aab1293788",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_42_MBUZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cab52cb6-fdb2-4c3d-9f04-65c276572a7d",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_41_NAMANCA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "be18f16e-5619-4e0b-8e15-e924695f4576",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_40_MUCO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "72d654b5-5aca-444d-9f3c-d5e51246a04a",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_39_MISSETA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "722ddadb-85e5-435c-b681-394855410016",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_38_NANGURU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8ee3201a-9455-4b01-b7b3-92c1f92173f2",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_37_INGURU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5869581e-0a2a-4b9b-87e6-98d9b319c07f",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_36_ZUNGULE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "148f1f7d-36ff-46cc-bf7e-284e4719b451",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_35_ZIMBAZE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ecb25c19-fcbb-4f82-b797-28be65603c08",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_34_YUAMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e4f9a3a6-e419-4396-aded-478eafc7a421",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_33_XINZIQUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8d471471-bdd2-4033-aeb1-4120123f32ce",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_32_XIMPACO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9458a13b-aee6-4017-b9d7-2ba12455c354",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_31_XIMANGO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "480f9ee1-ba31-4992-ba93-12c9f275b4ba",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_30_WINAZO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3b64314e-3e2c-4c0a-8021-26c6a254e218",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_29_VULAGUNDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4a1a5bd9-21ce-4be5-bf3b-e99ae3a8b28e",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_28_VIATURA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "84e56d76-d6e1-4c25-aee6-ea647a98e517",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_27_VERDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "382a4f6b-e4a4-4d9f-ad6d-0f88e143a276",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_26_TINGACO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7afe33d4-218b-403e-9645-25b7cfc99c6c",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_25_SANTOS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "efcadaeb-bfbd-46ba-af1a-e4c8b346e8e6",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_24_PONACO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1058d4af-ab5a-4ea6-a951-c6dc1ef0d9cf",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_23_PIRO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f482dd21-5b5a-4453-b404-b1a46fd5239a",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_22_PASSENDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "970b1841-436a-46dd-9867-444e95de2fca",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_21_OCUMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd6f33ab-bfa9-4b79-bfee-dc4161643176",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_20_OCUMALO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ac62e5ac-21e9-406c-9405-a653a1500a05",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_19_OCALIMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bd59b95d-e28e-41e9-90c9-fef24e46d38d",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_18_NALO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d9bf1cce-39eb-4546-b1c9-1a4a15b103c1",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_17_NABOARO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1deb9e6d-59e8-47e7-9ed8-d1baa062ff74",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_16_MUNGO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "936065ed-003c-48fa-aaae-a821e864db7d",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_15_MARIRIU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "85a2b1d4-97b2-4819-b942-98d67a1c371b",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_14_MAPIRORO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a6283206-169d-46f5-a6bf-35dd782e4442",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_13_MALUPIRIR",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "afff15e2-708e-41df-b56a-09fecd8ace56",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_12_MAFELENE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8ff926f2-1f91-454d-ad0b-66c56df77374",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_11_JUNHO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba5c1e38-ea9c-4597-a803-7fbc63389590",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_10_HODI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9e6e90c1-2fc3-4b1b-9be1-5b3c70b68917",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_09_FAMULO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f2a9488e-b4e5-45dd-968a-f778a587c242",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_08_FAHELO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "da28bb60-dd89-4221-a469-32b3110ff899",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_07_COTOMON_A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "938bfdcd-8390-4950-95cf-22d84a175c38",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_06_COLOMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "bbd05c6c-7fa9-402e-9690-7d4616998535",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_05_CHIPINHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5ab196b1-f8f2-4679-803a-0ed664cb51b7",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_04_CHIPANG_A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7d65f114-432f-40f9-8f96-8f6ebf3ba849",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_03_CHIPACO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "73d6b4bb-17be-4645-be8f-a3759591ad62",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_02_CHIGELA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "511b89dd-8a22-443c-924e-3f4976a484c4",
//                                                       "code": "MICROPLAN_MO_02_01_01_01_01_CHIMELO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   },
//                   {
//                       "id": "5b5de550-54c5-485d-b137-54379ea187ab",
//                       "code": "MICROPLAN_MO_01_NAMPULA",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "49c386ce-40f0-4370-bd6e-21503b5eebc6",
//                               "code": "MICROPLAN_MO_01_02_MURRUPULA",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "567fd944-eadb-4c39-bee8-6e6573e2b4b3",
//                                       "code": "MICROPLAN_MO_01_02_04_MUALDZI",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "91f1943f-f628-421d-910f-c0f3390426dc",
//                                               "code": "MICROPLAN_MO_01_02_04_01_KHAMANDE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "181f2cf2-e354-42bd-ba83-ee63c7b9135b",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_19_TCHALE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "90db4871-bc50-48eb-954d-b283eca0dbcd",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_18_MULAMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6b86f20d-9ce5-477f-b583-29b081d494cb",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_17_FAIZAZE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3c43c39c-5eaa-4555-9924-1a4d9fe1df50",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_16_CHICAONDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba842444-2307-40ae-a16b-19f1d7b67035",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_15_KAPAMANGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1f29862a-d09d-45e3-a2fe-feb4a2f158e7",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_14_KANKHUKU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b422d25b-e07c-42b7-8b0a-2b0f3ab2a4dd",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_13_CHAWANTA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "131ea497-9644-4d40-8ef3-65ed83501d8a",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_12_JASSONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "85afc761-417a-47db-8684-0acbe23d8244",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_11_DZICO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8bc03d76-28d8-42c4-a4c6-f110ceb6a11d",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_10_CALIDZIPIRE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "df79e3e3-26fc-4895-968d-2c41d912a0cf",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_09_CHIGONDO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "14da9fe8-73f3-4a49-9ad8-d5d9076f1551",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_08_CANQUIRA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "58b8dda6-e1e3-4056-8eca-42115c3f28f4",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_07_ALISSONE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7637c4e1-778a-4d7f-acda-70003d47e07d",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_06_MASSIMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6c3b74e1-7349-445b-a1c8-a28601051aba",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_05_NKONDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c035a40d-a28b-4644-859b-dd48b12f42f1",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_04_MASSAUASSAUA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4ce29e42-299f-406c-9afe-e4276ce75804",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_03_CASSOCHELA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d5449111-4538-4598-afe2-e7df4bb7e34e",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_02_SEQUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9fb25d9d-1726-4a26-9d15-506230f590a4",
//                                                       "code": "MICROPLAN_MO_01_02_04_01_01_KHAMANDE_SEDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "c7c9ed1a-a2fc-47cb-a32d-1904b0b7b47b",
//                                       "code": "MICROPLAN_MO_01_02_03_CHIFUNDE_01",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "3a1ae65b-fb07-4e29-a043-8f0c7e70c9f0",
//                                               "code": "MICROPLAN_MO_01_02_03_01_MUALADZI",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "beffec78-9083-4f6b-a775-45c66d251902",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_36_ANTIGA_MIGRACAO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "19e81975-e52a-4b31-bf7d-dd352a65c80e",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_35_CHITHAWALE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4e59821f-721a-4f29-9691-eb9921de3131",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_34_NHATIKOWA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "441d917b-8980-4063-aa4c-6af3c170778b",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_33_MALAZA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e4493326-5a08-45ac-a739-e5265093de03",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_32_MPHANJAYAUTSI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "74d5de59-9f00-429b-807c-aa06dceb09b5",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_31_NROLO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c92358c2-4c5d-4f17-b6b7-05a99d13ff82",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_30_MBOMBE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "55afade3-61f6-4a24-bf79-882c7c941ed6",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_29_AMOSSE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2a8294d1-34ec-4af9-99f1-fc4e3e61e984",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_28_WERENGANI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8052c70d-04e5-4897-9769-def6b29259ff",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_27_MAGRENI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6ca66ca0-a3c8-4343-a5d5-42e2fba724ac",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_26_CHIMPOYO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ef6dae91-da06-4425-9182-69e05e5425cf",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_25_CAWELENGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e04270c8-0401-44fe-a517-daf8731da249",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_24_MALIDZIMAERA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1539dedc-99eb-4421-9e6c-2179d61f7ac2",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_23_VUBUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9b973138-4005-4e2c-acb6-4cc3f901b3e9",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_22_MANKACA_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "b4dcf83e-0a28-4c11-ba39-5bfaff0fb1e0",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_21_NKHONDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1f38b518-16c4-4719-a91c-6508d866cdf5",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_20_GUEROSSOMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "84a25f0f-60c6-4ce9-81d1-20ff7e7d4f80",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_19_PHOCA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d91916fe-270b-468e-8860-5f22c46b83f0",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_18_THIMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a3349a3a-baf3-43fb-ada0-55c65b577c23",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_17_GOELA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "019a33b4-866d-467e-9ade-e9f8504919b4",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_16_DAUNDELA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e0da960c-db3b-4517-9dad-ba505ce31c9b",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_15_CHIRUDZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3d53a501-db5b-4c27-a16a-18a99650c646",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_14_MANKACA_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "db39a93d-9686-43f5-9c96-ab31aac68b54",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_13_NCHENGOERA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5b673e79-efc4-4b11-8ce2-bd6b211c6300",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_12_MULAWE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "546418c8-7024-4503-b0ca-646b78229808",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_11_CHOLONNGUELERA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a2bb6b09-954d-4f7f-929b-b209e45a6084",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_10_MUANANHANJE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ba7798ec-dc91-4395-ac3e-67e54c37a3bc",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_09_DZIWELANGONA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "637975c8-6e3a-4921-a373-9bb04e3c574a",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_08_CATAKWALA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "de52b000-545e-4842-8501-afb75edc9107",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_07_TSEBONDO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9285b46c-d56d-43ff-9d18-94cf8d5de4d7",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_06_SATEMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8cf62ee9-15e2-4ebf-8d81-e7af18a5effe",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_05_NAMICOMBO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "10b153b0-1351-400d-948f-d3a90b47c476",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_04_CHATSICA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "443e4e3e-41a9-4088-b178-97fb8edd278e",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_03_CHIMBALAME",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5b0cf076-de4e-4989-9d43-2159974da16f",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_02_CHITUMBULA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cc9ccf54-1be3-4278-aaf1-4f1104dd2c28",
//                                                       "code": "MICROPLAN_MO_01_02_03_01_01_MUALADZI_SEDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "2f398767-fd10-4e62-9af3-ca49a15fa063",
//                                       "code": "MICROPLAN_MO_01_02_02_CHITEEIMA",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a0aebf01-a14c-45fe-97b2-295882598713",
//                                               "code": "MICROPLAN_MO_01_02_02_02_CHICOA_NOVA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "de5e4b5d-84db-4a6c-b296-86d8a5ac2636",
//                                                       "code": "MICROPLAN_MO_01_02_02_02_05_NHAMINHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5d4001c8-afc3-4503-8846-2c6bdacee90d",
//                                                       "code": "MICROPLAN_MO_01_02_02_02_04_CHICOA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e6b71dec-b0e4-4653-9e4f-2e805b2ca65b",
//                                                       "code": "MICROPLAN_MO_01_02_02_02_03_CHINHANDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "633b1ee5-9c9e-4873-8dc7-b1c97675d33f",
//                                                       "code": "MICROPLAN_MO_01_02_02_02_02_MASSECHA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0dce8d06-3e23-41c3-a905-d3223971e3ab",
//                                                       "code": "MICROPLAN_MO_01_02_02_02_01_MATUNGULU",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "eb9c6e8f-e503-43a7-833b-d3193d039fd4",
//                                               "code": "MICROPLAN_MO_01_02_02_01_CHIBAGADIGO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "68560110-23cc-4fb2-9aa1-1cadd593dcc5",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_13_CHABONGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "43abb24f-ab7f-421f-982d-35ee6243adc1",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_12_CHISSUA_THALA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "910086c2-d2c0-41ef-af2d-b84f4c602d2e",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_11_CHISSUA_CRUZAMENTO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0ed0bbd7-a911-48d0-90f9-4610c292847f",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_10_CHISSUA_SEDE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a41fdc55-8408-4a97-bd9e-52bdf18d4cf7",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_09_CAVULANCIE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "254ce32c-8676-4294-878d-928f282a770a",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_08_NHAMIDZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0b20a2ec-8f87-44a0-81d3-4cd4c7869ebd",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_07_NHANTSINGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "eab5dcf5-5f8c-4877-8b43-35fd39ac660c",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_06_CHIRODZI_NTEPE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e94c671f-38b5-4c51-9d2c-5854ccc2e1d7",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_05_CHAMIMBA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9e570ad2-ad04-4cdf-a7e9-9fd39229a53d",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_04_NCHENGA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1412b9f6-c37e-4eef-8252-a096eb0cfb38",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_03_NHAULIRI_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f58ef4a7-429b-4303-8a17-8437e6b12693",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_02_NHAULIRI_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d321193f-761b-40a9-ae12-718a045331b0",
//                                                       "code": "MICROPLAN_MO_01_02_02_01_01_CHIRODZI_PONTE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "6b3eceac-3cc2-4a62-a1a0-6dd9cc531c55",
//                                       "code": "MICROPLAN_MO_01_02_01_NIHESSIUE",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "a8246f4b-4c2e-4699-b608-f0f28cee11a0",
//                                               "code": "MICROPLAN_MO_01_02_01_03_NIHESSIUEA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "2b05d263-d641-4bda-9751-8f4929f2416b",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_29_CAVINA1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ec9204b6-3917-4b44-b4bf-8e7b65a2451f",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_28_CAVINA2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ada71b18-b57f-420e-bc35-8bc30b574adc",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_27_CAVINA3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ceed29a4-3583-42dd-ae10-7f00b596e890",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_26_CAVINA4",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "1e544e97-6ca4-42f5-bcef-2a47e9bbcddf",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_25_CAVINA5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "669b8669-d361-47a7-a576-0aba66a0ef0c",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_24_CAVINA6",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "312b291d-c58b-4967-a5d7-e46287839111",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_23_CAVINA7",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0c899bb7-a40f-495b-becc-a12ed0d8a552",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_22_CAVINA8",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2bb47f0b-9527-4ca0-b8a2-698471741a7b",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_21_CAVINA9",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "90148fb8-e4c4-4fc4-87c4-8a27c3af2dbc",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_20_CAVINA10",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "7f5313d5-f174-426f-86da-6e9f72ce986d",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_19_CAVINA11",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a592bac5-788f-48fc-9f57-04733d005183",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_18_CAVINA12",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "fc28c77e-3617-4208-a02b-292433bcf0ba",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_17_CAVINA13",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "787aaf8a-1487-4e51-899c-0a058520dad9",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_16_CAVINA14",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2ff6fc9c-2a3e-435a-b8da-43a378d9a5ae",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_15_CAVINA15",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "955f1cf7-c164-4423-8e9a-635859e8d0d7",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_14_CAVINA16",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "39efa498-00d8-4ae2-94b2-748cad48500c",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_13_CAVINA17",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "97fd1e31-8db1-4d49-90eb-ae0e17ed31ad",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_12_CAVINA18",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ec9965c0-1b45-4860-a383-d3796cf6cfbc",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_11_CAVINA19",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "344e7fd9-9b41-4488-843e-96184423628a",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_10_CAVINA20",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "df09fec7-4fdd-4eb6-ad01-785d3069abab",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_09_CAVINA21",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5dfac163-a5d4-4954-8eb3-0aa7e9e7fa66",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_08_CAVINA22",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cd61bd67-eeea-4ef8-a463-6e734c8adfc2",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_07_CAVINA23",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c36f0ff3-05ef-4a3b-8356-198eebd07790",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_06_CAVINA24",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "792944b4-ffcf-4d81-a613-47ed0151e72e",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_05_CAVINA25",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3989d251-448c-4607-995c-61391f776141",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_04_CAVINA26",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "343a321b-f17f-4fdf-8e54-6d92bfdc8ebd",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_03_CAVINA27",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3ce305a2-3883-4843-a401-3ffc0c978b56",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_02_CAVINA28",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "10dd07d3-dd56-423d-b48b-2c947c8caf24",
//                                                       "code": "MICROPLAN_MO_01_02_01_03_01_CAVINA29",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "8c4c7108-a25f-49db-ba80-44ba91218642",
//                                               "code": "MICROPLAN_MO_01_02_01_02_MULHANIUA",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "db4f1be3-9ffe-48cd-8aa9-5b6006caba99",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_10_NACULUER1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a211721b-144a-409e-8c25-8bde551f0dd8",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_09_NACULUER2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "3cfc295e-4ca1-4073-bad8-3a48bb4e1a6c",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_08_NACULUER3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "78926b24-5a48-495c-a881-0a886e41b43d",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_07_NACULUER4",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a6b7d414-7e60-4d46-bccf-35753665e528",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_06_NACULUER5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "78efdab6-2050-4b4a-8ff7-758a63b1d7ea",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_05_NACULUER6",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6f8da4bf-11d4-4a35-994a-2862027b309d",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_04_NACULUER7",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "289f9e69-6ac0-432f-b9a1-b6ecf0d237ee",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_03_NACULUER8",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "72811f7e-1a33-48d5-8640-f6d2498ac3fe",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_02_NACULUER9",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "eee0c971-1098-4575-9e62-81a541aa8957",
//                                                       "code": "MICROPLAN_MO_01_02_01_02_01_NACULUER10",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           },
//                                           {
//                                               "id": "cb1cc758-a102-4975-b9fc-cdf7e3d83067",
//                                               "code": "MICROPLAN_MO_01_02_01_01_NACOCOLO",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4fd6ab56-bc2f-494a-bb41-50f86a552718",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_09_NACOCOLOA1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0b0a5d23-83bc-421a-b243-ccce6c86947d",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_08_NACOCOLOA2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "16320bcd-8399-4467-ab61-1785a2389335",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_07_NACOCOLOA3",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "023d4674-5cbb-485d-9639-9e6fcc43437e",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_06_NACOCOLOA4",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5979f6db-362d-49e8-8cdb-9ea88cd11c8f",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_05_NACOCOLOA5",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "52d54ddf-2a50-4075-a919-faebfdda1b15",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_04_NACOCOLOA6",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "65b9bd96-92c2-4b50-9ce1-fc36789d5455",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_03_NACOCOLOA7",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2e9920fb-c2e4-44f6-aa3a-3002e2197ed1",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_02_NACOCOLOA8",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5917dcfe-bfe6-416a-ac89-f3369c03e703",
//                                                       "code": "MICROPLAN_MO_01_02_01_01_01_NACOCOLOA9",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           },
//                           {
//                               "id": "0d8559e3-5d8a-4cca-941b-d690d1f7f3b2",
//                               "code": "MICROPLAN_MO_01_01_MOSSURILEE",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "03d3d1c2-3338-4cf7-be97-5dcefabf2c26",
//                                       "code": "MICROPLAN_MO_01_01_02_NSADZO",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "bfb819b5-09bc-499c-aa47-448687178827",
//                                               "code": "MICROPLAN_MO_01_01_02_01_ANG_OMBE",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "f5f30882-89f6-4dc7-b475-444c4769fef7",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_23_MOAMBEDZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "6b9156e3-10b1-4930-b7cd-91322c6f75b1",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_22_MPHEMBERE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "cab8055e-316d-4024-a534-20bca01471ef",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_21_LIPIRANI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5c896c80-b34f-406c-ad5d-697b0ccbf985",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_20_CHANGUI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "d47b162c-eebe-4772-80e5-796ca8132d4e",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_19_CAPOCHI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4c6cb836-9d56-46ae-9927-daefcfce6473",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_18_MAXENECA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f7761ebf-46fe-472c-8d4b-bcb231f99623",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_17_ANANIAS",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "8ff8ca70-df9b-4a05-8bca-5f3966990c89",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_16_TSHIRIZA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9cf39eea-d49b-4537-b7dc-c209711a65a3",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_15_COFATI_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9b882d4a-ebab-49ad-8cc0-dc3429680ecd",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_14_KAPHIRI_KA_MPANDA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e5b91f7f-708f-4148-8137-1d7b86850424",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_13_AMBULEZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "83489457-d45c-40fd-886c-cbbed720d377",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_12_ACHINTSUE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "5b298e30-f291-4a49-bc61-20f54b5566bf",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_11_NCUMBUZI_2",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2c7cae36-073b-4084-9301-e9296b38a7ab",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_10_NCUMBZI_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "16385979-059b-489e-b636-81c6b1baa6ac",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_09_NTUITI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "49440042-083b-4300-8424-2f08a244df09",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_08_ACUSE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "4dbc45f5-e586-4e69-9e1a-30b853448c31",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_07_ADAMO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "de2818a0-1d6a-4b42-aef6-c265a5aed199",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_06_AFULEDI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e5147d2e-404c-4345-a64c-7a4f696ec4fc",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_05_COFATI_1",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "a6f6a4b8-c1ae-4fb8-a4fb-64a4657ebbe2",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_04_JULIO_CHAMALULO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2af108f4-32f4-4c24-b1f0-a60bee528ef7",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_03_MACATA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "10c6cc39-36ed-426d-96a8-e8172c1cd41f",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_02_ZANICHI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "9e5df08b-89f8-42fb-be7c-48c7817b50ba",
//                                                       "code": "MICROPLAN_MO_01_01_02_01_01_THEQUESSE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   },
//                                   {
//                                       "id": "27b60f0d-fd01-4c88-9b6d-038d4180dc2c",
//                                       "code": "MICROPLAN_MO_01_01_01_CHITIMA_01",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "50ba10b9-2b3a-4525-a73d-e1b7679874f6",
//                                               "code": "MICROPLAN_MO_01_01_01_01_CHITIMA_SEDE_01",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "df52a33d-1c4e-4c24-9b72-8b5cd35607d2",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_16_CAWIRA_A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "c7978c2b-d624-4b75-ac7a-2df8a4f20bd4",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_15_CAWIRA_B",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "de10ab92-68b3-485e-8301-bcda42a7a16b",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_14_VALE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "335d5dfe-ddd3-4509-96f6-16c638ce92ae",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_13_25_DE_JUNHO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e6e58d86-884f-4fa8-a608-7c0412852a11",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_12_JOSINA_MACHEL",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "e6f631cd-63a7-4c70-88d0-25de62748dad",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_11_CATOND_O",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2c2c1601-1285-4ac7-92ea-e0161b0562cd",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_10_1_DE_M_AIO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "212c2a70-b45e-4202-a186-673032c45d3a",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_09_CAHO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "185391ff-2c8e-4555-a0c6-ddf63df4dc43",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_08_BOROMA",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "888c43c5-57c7-408d-9ab9-76b301afe486",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_07_CADONG_OLO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "f3075a54-9c1e-4c38-8b41-b387b6887b61",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_06_GUEBUZ_A",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "126419fa-a8a8-470c-92c6-5f1d1ae638b7",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_05_CHITHA_NDO",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "2861bbfa-1910-4f60-bc94-8012a47891b6",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_04_NHANTS_UNGUI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "ca74f33a-0a66-4b56-9e4d-c7207edc50d4",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_03_CARANG_ACHE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "0469f34e-674d-4af9-919a-aee3ed4b5d3a",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_02_CANDOD_O",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   },
//                                                   {
//                                                       "id": "663630d5-08ed-4b33-a2d6-f56c1e4e29db",
//                                                       "code": "MICROPLAN_MO_01_01_01_01_01_CANGUD_ZI",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   }
//               ]
//           },
//           {
//               "id": "d094e9ba-519d-495b-b084-d3f04632f87f",
//               "code": "MICROPLAN_MI",
//               "boundaryType": "COUNTRY",
//               "children": [
//                   {
//                       "id": "3884f2f0-5d56-4859-8d63-96687a20ed0c",
//                       "code": "MICROPLAN_MI_01_MICROPLAN_PROVINCE",
//                       "boundaryType": "PROVINCE",
//                       "children": [
//                           {
//                               "id": "ea777670-cd33-4f75-8ab5-ea9918288ab1",
//                               "code": "MICROPLAN_MI_01_01_MICROPLAN_DISTRICT",
//                               "boundaryType": "DISTRICT",
//                               "children": [
//                                   {
//                                       "id": "ece9157a-0551-419e-a66c-f10eb83f553d",
//                                       "code": "MICROPLAN_MI_01_01_01_MICROPLAN_ADMINISTRATIVEPOST",
//                                       "boundaryType": "ADMINISTRATIVEPOST",
//                                       "children": [
//                                           {
//                                               "id": "c23f90f9-b323-47af-bd56-2ac6dc08a6d6",
//                                               "code": "MICROPLAN_MI_01_01_01_01_MICROPLAN_LOCALITY",
//                                               "boundaryType": "LOCALITY",
//                                               "children": [
//                                                   {
//                                                       "id": "4d6b49be-6a0b-450f-bb3c-614c36fc9a2e",
//                                                       "code": "MICROPLAN_MI_01_01_01_01_01_MICROPLAN_VILLAGE",
//                                                       "boundaryType": "VILLAGE",
//                                                       "children": []
//                                                   }
//                                               ]
//                                           }
//                                       ]
//                                   }
//                               ]
//                           }
//                       ]
//                   }
//               ]
//           }
//       ]
//   }
// ]


const processHierarchy = (nodes, parentPath = "") => {
  // debugger;
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

// return processHierarchy(data?.TenantBoundary?.[0]?.boundary)

// const [hierarchy,setHierarchy]=useState(preHierarchy[0]?.boundaryHierarchy);
// const [hierarchyData,setHierarchyData]=useState([processHierarchy(preHierarchyData[0]?.boundary)[0]])


  // debugger;

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
      includeChildren: true
    },
    body: {},
    config: {
      enabled: BOUNDARY_HIERARCHY_TYPE? true: false,
      select: (data) => {  
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
  console.log("222",hierarchyData);
  

  // const hierarchyData = hierarchyData1;
  // boundaryOptions={
  //   administrative:[{path:administrative.province,code:"XYZ"},{path}]
  // }


  const [boundaryOptions, setBoundaryOptions] = useState({});
  const [selectedValues,setSelectedValues]=useState([]);

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

  useEffect(() => {

      if (hierarchy) {
          const highestIndex = hierarchy?.findIndex(item => item?.boundaryType === props?.highestLevel);

          if (highestIndex !== -1) {
              const tempNonEditableHierarchies = new Set(hierarchy.slice(0, highestIndex).map(item => item.boundaryType));

              setNonEditableHierarchies(tempNonEditableHierarchies);
          }
      }
}, [hierarchy, props.highestLevel]);


  // useEffect(() => {
  //   if (hierarchyData) {
  //     console.log("1111 hierarchyData", hierarchyData);
  //   }
  // }, [hierarchyData]);

  console.log("byeee");
  const rootBoundaryType = hierarchy?.filter((item) => item?.parentBoundaryType === null)[0]?.boundaryType;
  


  const findNodeByPath = (nodes, targetPath) => {
    // debugger;
    console.log("nodes",nodes);
    if(!nodes || nodes.length==0){return}
    for (const node of nodes) {
      if (node.path === targetPath) {
        console.log("node search",node.children?.map(child => ({ code: child.code,id:child.id, path: child.path })) || []);
        return node.children?.map(child => ({ code: child.code,id:child.id, path: child.path,boundaryType:child.boundaryType })) || [];
      }
      if (node.children && node.children.length > 0) {
        const result = findNodeByPath(node.children, targetPath);
        if (result) return result; // If found in the recursive call, return result
      }
    }
    return null; // Return null if no match is found
  };
  if(hierarchyData){
    console.log("1111 Node by path",findNodeByPath(hierarchyData,"MICROPLAN_MO.MICROPLAN_MO_16_FCT__ABUJA_STATE"));

  }

  const recursiveCleanup = (currentBoundaryType, updatedOptions, codesToRemove) => {
    // debugger;
    console.log("1111 recursive", currentBoundaryType, updatedOptions, codesToRemove);
    const childType = hierarchy.find(item => item.parentBoundaryType === currentBoundaryType)?.boundaryType;
    if (!childType || !updatedOptions[childType]) return updatedOptions;

    // updatedOptions.[childType] = { ...updatedOptions, [childType]: { ...updatedOptions[childType] } };

    Object.keys(updatedOptions[childType]).forEach(code => {
        console.log("1111 boundary options here", updatedOptions[childType], code, childType);

        const shouldDelete = updatedOptions[childType][code].some(child => {
            console.log("Checking child:", child, codesToRemove, child.path);
            const hasMatch = codesToRemove.some(code => child.path.includes(code));
            console.log("1111 Matching Code:", hasMatch, codesToRemove, currentBoundaryType);
            return hasMatch;
        });

        console.log("1111 delete", shouldDelete);


        if (shouldDelete) {
            // debugger;
            console.log("1111 hello should Delete", shouldDelete, updatedOptions, childType, code, updatedOptions[childType][code]);
            console.log("1111 hello before delete", updatedOptions[childType],childType,code);
            delete updatedOptions[childType][code];
            // const { [code]: deleted, ...rest } = updatedOptions[childType]; // Safe deletion
            // console.log("1111 hello deleted", deleted, rest);
            // updatedOptions[childType] = rest;
            console.log('1111 hello after delete', updatedOptions[childType],childType,code);
        }
    });

    console.log("1111 boundary options here1", updatedOptions, childType, codesToRemove);

    // Recursively clean next level
    return recursiveCleanup(childType, updatedOptions, codesToRemove);
};

  const cleanLowerLevels = (boundaryType, codesToRemove, updatedOptions) => {
    console.log("1111 cleanlowerlevels begining", boundaryType, codesToRemove,updatedOptions);
    if(codesToRemove.length==0) return updatedOptions;

    console.log("1111 cleanlowerlevels", boundaryType, codesToRemove);
    console.log("hellooooo");
    console.log("1111 boundary options here before", updatedOptions);

    let newBoundaryOptions=recursiveCleanup(boundaryType, updatedOptions, codesToRemove);
    console.log("1111 newboundary options after removing are", newBoundaryOptions);

    return newBoundaryOptions; // Return the final updated state
};

const cleanLowerLevelsForSelectedValues = (boundaryType, removedCodes, updatedOptions) => {

    return updatedOptions.filter(option => {
        // Ensure path is a valid string before checking `includes`
        if (typeof option?.path !== "string") return true;

        return !removedCodes.some(code => option.path.includes(code));
    });
};








const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));
const boundaryOptionsUpdate = async (boundaryType, values) => {
    console.log("1111 boundaryOptionsUpdate:", boundaryType, values);
    if (!Array.isArray(values)) return;

    const selectedOptions = values.map(arg => arg[1]) || [];
    console.log("boundaryOptionsUpdate:", boundaryType, selectedOptions);

    const childBoundaryType = hierarchy.find(
        (item) => item.parentBoundaryType === boundaryType
    )?.boundaryType;

    const removedCodes = [];
    const processRemovedCodes = (previousValues, selectedCodes) => {
        Object.keys(previousValues).forEach(code => {
            if (!selectedCodes.has(code)) {
                removedCodes.push(code);
                console.log("1111 Removed code:", code);
            }
        });
    };

    const previousValues = boundaryOptions[childBoundaryType] || {};
    const selectedCodes = new Set(selectedOptions.map(v => v.code));
    processRemovedCodes(previousValues, selectedCodes);
    console.log("Removed codes:", removedCodes);

    const updatedOptions = boundaryOptions;
    let newBoundaryOptions = {};
    let newSelectedOptions = {};

    if (removedCodes.length > 0) {
        newBoundaryOptions = cleanLowerLevels(boundaryType, removedCodes, { ...boundaryOptions });
        newSelectedOptions = cleanLowerLevelsForSelectedValues(boundaryType, removedCodes, [...selectedValues]);
    } else {
        await delay(200);
        newBoundaryOptions = updatedOptions;
        newSelectedOptions = selectedValues;
    }

    console.log("1111 NewboundaryOptions:", newBoundaryOptions, selectedValues);

    // **Accumulate changes before updating state**
    let updatedSelectedValues = [...newSelectedOptions];

    setBoundaryOptions((prev) => {
        console.log("Previous boundaryOptions:", prev);
        let updatedOptions = { ...newBoundaryOptions };

        // **Memoizing the children lookups**
        const childrenMap = new Map();

        selectedOptions.forEach((value) => {
            console.log("Processing value:", value);
            
            // **Update selected values locally**
            const existingCodes = new Set(updatedSelectedValues.map(v => v.code));
            if (!existingCodes.has(value.code)) {
                updatedSelectedValues.push(value);
            }

            if (boundaryType !== props.lowestLevel) {
                if (!childrenMap.has(value?.path)) {
                    childrenMap.set(value?.path, findNodeByPath(hierarchyData, value?.path));
                }
                const children = childrenMap.get(value?.path);
                console.log("Children:", children);

                updatedOptions[childBoundaryType] = updatedOptions[childBoundaryType] || {};
                updatedOptions[childBoundaryType][value?.code] = updatedOptions[childBoundaryType][value?.code] || [];

                const existingEntries = new Set(
                    updatedOptions[childBoundaryType][value?.code].map(child => child.code)
                );

                console.log("Existing entries:", existingEntries);

                const uniqueChildren = children.filter(child => !existingEntries.has(child.code));
                console.log("Unique children:", uniqueChildren);

                updatedOptions[childBoundaryType][value?.code] = [
                    ...updatedOptions[childBoundaryType][value?.code],
                    ...uniqueChildren
                ];
            }
        });

        return updatedOptions;
    });

    // **Update selected values once at the end**
    setSelectedValues(updatedSelectedValues);
};






useEffect(() => {
    console.log("Updated SelectedValues (useEffect):", selectedValues);
}, [selectedValues]);





  
  
  console.log("1111 boundaryOptions",boundaryOptions);
  
  // if(hierarchy && hierarchyData){
  // boundaryOptionsUpdate( 
  //   "POSTADMINISTRATIVE", 
  //   [{path:"NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER",code:"NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER"},
  //     {path:"NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC",code:"NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC"}]);

  //   }
    // useEffect(() => {
    //   if (hierarchy && hierarchyData) {
    //     boundaryOptionsUpdate( 
    //       "POSTADMINISTRATIVE", 
    //       [
    //         {
    //           path: "NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER",
    //           code: "NEWTEST00222_MO_11_06_05_PLEEBO_HEALTH_CENTER"
    //         },
    //         {
    //           path: "NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO.NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC",
    //           code: "NEWTEST00222_MO_11_06_04_GBLOKEN_CLINIC"
    //         }
    //       ]
    //     );
    //   }
    // }, [hierarchy, hierarchyData]);



    const initializeBoundaries = (nodes, updatedOptions, nonEditableHierarchies) => {
        // debugger
        if (!nodes || nodes.length === 0) return updatedOptions; 
    
        // If the current node's boundaryType is not in the editable set, return early
        if (!nonEditableHierarchies.has(nodes[0]?.boundaryType)) {
            return updatedOptions;
        }
    
        // Find the child boundary type of the current level
        const childBoundaryType = hierarchy.find(
            (item) => item.parentBoundaryType === nodes[0]?.boundaryType
        )?.boundaryType;
    
        if (!childBoundaryType) return updatedOptions; // If no child boundaryType exists, return
    
        // Ensure the structure exists in updatedOptions
        updatedOptions[childBoundaryType] = updatedOptions[childBoundaryType] || {};
    
        for (const node of nodes) {
            updatedOptions[childBoundaryType][node.code] =
                updatedOptions[childBoundaryType][node.code] || [];
    
            // Extract relevant children details
            const children = node.children?.map(child => ({
                code: child.code,
                id: child.id,
                path: child.path,
                boundaryType: child.boundaryType
            })) || [];
    
            updatedOptions[childBoundaryType][node.code].push(...children);
    
            // Recursively process child nodes while persisting updatedOptions
            initializeBoundaries(node.children, updatedOptions, nonEditableHierarchies);
        }
    
        return updatedOptions; // Always return the modified object
    };
    
    useEffect(() => {
        if (!hierarchyData || !hierarchy) return;
    
        // Initialize boundary options with root boundary type
        let initialBoundaryOptions = {
            [rootBoundaryType]: [{
                path: hierarchyData[0]?.path,
                code: hierarchyData[0]?.code,
                id: hierarchyData[0]?.id,
                parent: null
            }]
        };
    
        // Initialize with a new object to ensure no unwanted mutations occur
        let tempBoundaryOptions = initializeBoundaries(
            hierarchyData,
            { ...initialBoundaryOptions }, 
            nonEditableHierarchies
        );
        debugger;
    
        // Ensure that all levels exist even if they have no children
        hierarchy.forEach((item) => {
            console.log("boundaryType0",nonEditableHierarchies,item?.boundaryType)
            if (!nonEditableHierarchies.has(item?.boundaryType) && item?.boundaryType!==props.highestLevel) {
                console.log("boundaryType1",item?.boundaryType);
                tempBoundaryOptions[item?.boundaryType] = {};
            }
        });
    
        setBoundaryOptions(tempBoundaryOptions);
    
    }, [hierarchyData, hierarchy, nonEditableHierarchies]);
    
    

    console.log("initial boundary options",boundaryOptions);

     // hierarchyData.forEach((item2) => {
        //     if (!nonEditableHierarchies.has(item2.boundaryType)) return;
    
        //     // Ensure boundaryType exists in tempBoundaryOptions
        //     if (!tempBoundaryOptions[item2.boundaryType]) {
        //         tempBoundaryOptions[item2.boundaryType] = {};
        //     }
    
        //     // Ensure code exists within the boundaryType
        //     if (!tempBoundaryOptions[item2.boundaryType][item2.code]) {
        //         tempBoundaryOptions[item2.boundaryType][item2.code] = [];
        //     }
    
        //     item2.children?.forEach((item3) => {
        //         tempBoundaryOptions[item2.boundaryType][item2.code].push({
        //             code: item3.code,
        //             path: item3.path,
        //             boundaryType: item3.boundaryType,
        //             id: item3.id
        //         });
        //     });
        // });
    
    // useEffect(()=>{
    //     // debugger
    //     // console.log("1111 useffect")
    //     if(!hierarchyData || !hierarchy) return;
    //     setBoundaryOptions((prev)=>({
    //       ...prev,
    //       [rootBoundaryType]:[{path:hierarchyData[0]?.path,code:hierarchyData[0]?.code,id:hierarchyData[0]?.id,parent:null}]
    //     }
    //     ))
    //     hierarchy.filter((item1)=>item1?.boundaryType!=rootBoundaryType)?.forEach((item)=>{
    //         setBoundaryOptions((prev)=>({
    //             ...prev,
    //             [item?.boundaryType]:{}
    //         }))
    //     })
    //   },[hierarchyData,hierarchy])
 

 

  

  
  
  console.log("1111 hiii1", rootBoundaryType);
  console.log("1111 hierarchyData",hierarchyData);
  console.log("1111 boundary options",boundaryOptions);

  if(boundaryOptions && boundaryOptions[rootBoundaryType]){
    console.log("1111 rootboun",boundaryOptions[rootBoundaryType]);
  }
  // debugger;
  console.log("1111 res",hierarchy ,hierarchyData ,boundaryOptions);
  console.log("non",nonEditableHierarchies)

  return (
    <div className="selecting-boundary-div">
       {
         hierarchy && hierarchyData && boundaryOptions[rootBoundaryType] && hierarchy?.filter((boundary,index) => {
            // Find the index of the lowest hierarchy
            // debugger;
            // debugger
            const lowestIndex = hierarchy?.findIndex((item) => item?.boundaryType === props.lowestLevel);
            const highestIndex = hierarchy?.findIndex((item) => item?.boundaryType === props.highestLevel);
            // console.log("1111", "filter",highestIndex,lowestIndex,index,props.highesLevel);
            return highestIndex<=index && index<= lowestIndex;
          })?.map((item) => {
           
  
        return (item?.boundaryType === rootBoundaryType) ? (
         <LabelFieldPair style={{ alignItems: "flex-start", paddingRight: "30%" }}>
            <CardLabel className={"boundary-selection-label"}>
                    {item?.boundaryType}
            </CardLabel>
          <div className="digit-field">
          <MultiSelectDropdown
            key={item?.boundaryType}
            clearLabel="Clear All"
            options={boundaryOptions[rootBoundaryType]}
            optionsKey={"code"}
            t={t}
            onSelect={(values) => {
            //   debugger
            console.log("onselect",values);
              boundaryOptionsUpdate(item?.boundaryType, values);
            }}
            type="multiselectdropdown"
            config={{
                isDropdownWithChip:true
              }}
          />
          </div>
          </LabelFieldPair>)
          : (() => { 
            const boundaries = boundaryOptions[item?.boundaryType];

            if (boundaries) {
              const formattedOptions = Object.keys(boundaries).map((parentKey) => ({
                code: parentKey,
                name: parentKey,
                options: boundaries[parentKey].map((child) => ({
                  code: child.code,
                  name: child.code,
                  path: child.path,
                  parent: parentKey,
                  boundaryType:child.boundaryType
                })),
              }));

              console.log(item?.boundaryType,"formatted options",formattedOptions);
            
              const formattedSelectedValues=selectedValues.filter((child)=>child?.boundaryType===item?.boundaryType);
            //   debugger;
              
           
            
            

              console.log(item?.boundaryType,"formatted selected",formattedSelectedValues);

            
            
              return (
                <LabelFieldPair style={{ alignItems: "flex-start", paddingRight: "30%" }}>
                      <CardLabel className={"boundary-selection-label"}>
                      {t((hierarchyType + "_" + item?.boundaryType).toUpperCase())}
                      </CardLabel>
                  <div className="digit-field">
                    <MultiSelectDropdown
                      key={item?.boundaryType}
                      clearLabel="Clear All"
                      options={formattedOptions}
                      selected={formattedSelectedValues}
                      optionsKey={"name"}
                      t={t}
                      onSelect={(values) => {
                        console.log("onclose",values,item?.boundaryType)
                        boundaryOptionsUpdate(item?.boundaryType, values);
                      }}
                      addCategorySelectAllCheck={true}
                      addSelectAllCheck={true}
                      type="multiselectdropdown"
                      variant="nestedmultiselect"
                      config={{
                        isDropdownWithChip:true
                      }}
                    />
                  </div>
                </LabelFieldPair>
              );
            }
            
  
          return null; // Avoids rendering errors when `boundaries` is undefined
        })();
        
      })} 
    </div>
 

 
);
  
}

export default BoundaryFilter       