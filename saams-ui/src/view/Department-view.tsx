import * as React from 'react';
import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { Refresh, Add, Delete, Update } from '@mui/icons-material';
import { Department, DepartmentResponse } from '../model/department';

function createData(
  id: number,
  code: string,
  name: string,
) {
  return { id, code, name };
}

const handleOnGet = async () => {
  const id = await window.electronAPI.getDepartments();
  console.log(id);

  return id;
}

export default function DepartmentView() {
  const [rows, setRows] = React.useState<Department[]>([]);
  const [initialLoad, setInitialLoad] = React.useState<boolean>(true);

  const handleRefreshButtonClick = async () =>  {
    const response = await handleOnGet();
    console.log(response);
    const input = response.departments;
    const updatedRows = [
      ...rows,
      ...input.filter(
        (newEntry) => !rows.some((existingEntry) => existingEntry.id === newEntry.id)
      ),
    ];

    setRows(updatedRows);
  }

  const handleAddButtonClick = async () => {

  }

  const handleUpdateButtonClick = async () => {
    
  }

  const handleDeleteButtonClick = async () => {
    
  }

  React.useEffect(() => {
    if (initialLoad) {
      handleRefreshButtonClick();
      setInitialLoad(false);
    }
  });

  return (
    <Stack spacing={2} direction="column">
      <Stack spacing={2} direction="row">
        <Button variant="contained" onClick={handleRefreshButtonClick}>Refresh <Refresh /></Button>
        <Button variant="contained" onClick={handleAddButtonClick}>Add <Add /></Button>
        <Button variant="contained" onClick={handleUpdateButtonClick}>Modify <Update /></Button>
        <Button variant="contained" onClick={handleDeleteButtonClick}>Delete <Delete /></Button>
      </Stack>
      <TableContainer component={Paper}>
      <Table sx={{ minWidth: 650 }} aria-label="simple table">
        <TableHead>
          <TableRow>
            <TableCell>ID</TableCell>
            <TableCell align="right">Code</TableCell>
            <TableCell align="right">Name</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {rows.map((row) => (
            <TableRow
              key={row.id}
              sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
            >
              <TableCell component="th" scope="row">
                {row.id}
              </TableCell>
              <TableCell align="right">{row.code}</TableCell>
              <TableCell align="right">{row.name}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>

    </Stack>
  );
}