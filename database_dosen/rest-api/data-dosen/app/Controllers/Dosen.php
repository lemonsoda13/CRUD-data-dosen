<?php

namespace App\Controllers;
use CodeIgniter\API\ResponseTrait;
use App\Models\DosenModel;

class Dosen extends BaseController
{
    use ResponseTrait;
    function __construct()
    {
        $this-> model = new DosenModel();
    }

    public function index()
    {
        $data = $this->model->orderBy('nama','asc')->findAll();
        return $this->respond($data, 200);
    }

    public function show($id=null){
        $data = $this->model->where('id', $id)->findAll();
        if ($data){
            return $this->respond($data, 200);
        }else{
            return $this->failNotFound("Data tidak ditemukan untuk id $id");
        }
    }

    public function create()
    {
        helper(['form']);

        $rules = [
            'nama' => 'required',
			'nidn' => 'required',
            'bidang' => 'required',
            'programstudi' => 'required',
        ];

        if(!$this->validate($rules)){
			return $this->fail($this->validator->getErrors());
		}else{

			//Get the file
            $data = [
                'nama' =>$this->request->getVar('nama'),
                'nidn' =>$this->request->getVar('nidn'),
                'bidang' =>$this->request->getVar('bidang'),
                'programstudi' =>$this->request->getVar('programstudi'),
            ];

            $this->model->save($data);
            $response = [
                'status' => 201,
                'error' => null,
                'messages'=>[
                    'success' => 'Berhasil memasukkan data dosen'
                ]
            ];
            return $this->respond($response);
		}
    }

    public function update($id = null){
        $data = $this->request->getRawInput();
        $data['id'] = $id;

        $isExist = $this->model->where('id', $id)->findAll();
        if (!$isExist){
            return $this->failNotFound("Data tidak ditemukan untuk id $id");
        }

        if (!$this->model->save($data)){//terdapat error saat menyimpan}
        return $this->fail($this->model->errors());
        }

        $response = [
            'status' => 201,
            'error' => null,
            'messages'=>[
                'success' => "Data Dosen berhasil di update dengan id $id"
            ]
        ];
        return $this->respond($response);
    }

    public function delete($id = null){
        $data = $this->model->where('id', $id)->findAll();
        if($data){
            $this->model->delete($id);
            $response = [
                'status' => 201,
                'error' => null,
                'messages'=>[
                    'success' => "Data Dosen berhasil dihapus "
                ]
            ];
            return $this->respondDeleted($response);
        }else{
            return $this->failNotFound('Data tidak ditemukan');
        }
    }
  
}