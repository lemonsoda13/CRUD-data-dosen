<?php
namespace App\Models;
use CodeIgniter\Model;

class DosenModel extends Model{
    protected $table = "dosen";
    protected $primaryKey = "id";
    protected $useAutoIncrement = true;
    protected $allowedFields = 
    [
        'id', 'nama', 'nidn', 'bidang', 'programstudi', 'image'
    ];

}